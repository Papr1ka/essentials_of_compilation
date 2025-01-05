import ast
from ast import *
from graph import UndirectedAdjList
from utils import *
from x86_ast import *
import os
from typing import List, Tuple, Set, Dict
from priority_queue import PriorityQueue

Binding = Tuple[Name, expr]
Temporaries = List[Binding]


class Compiler:

    ############################################################################
    # Partial Evaluation
    ############################################################################

    def pe_exp(self, e: ast.expr):
        match e:
            case ast.Constant(int()) | ast.Call(ast.Name("input_int"), []) | ast.Name():
                return e
            case ast.UnaryOp(ast.USub(), expr):
                expr = self.pe_exp(expr)
                match expr:
                    case ast.Constant(value):
                        return ast.Constant(neg64(value))
                    case _:
                        return ast.UnaryOp(ast.USub(), expr)

            case ast.BinOp(left, (ast.Add() | ast.Sub()) as op, right):
                left = self.pe_exp(left)
                right = self.pe_exp(right)

                match (left, right):
                    case (ast.Constant(value0), ast.Constant(value1)):
                        match op:
                            case ast.Add():
                                return ast.Constant(add64(value0, value1))
                            case ast.Sub():
                                return ast.Constant(sub64(value0, value1))
                    case (
                        ast.BinOp(ast.Constant(value0), ast.Add(), right),
                        ast.Constant(value1),
                    ):
                        match op:
                            case ast.Add():
                                return ast.BinOp(
                                    ast.Constant(value0 + value1), ast.Add(), right
                                )
                            case ast.Sub():
                                return ast.BinOp(
                                    ast.Constant(value0 - value1), ast.Add(), right
                                )
                    case (
                        ast.Constant(value0),
                        ast.BinOp(ast.Constant(value1), ast.Add(), right),
                    ):
                        match op:
                            case ast.Add():
                                return ast.BinOp(
                                    ast.Constant(value0 + value1), ast.Add(), right
                                )
                            case ast.Sub():
                                return ast.BinOp(
                                    ast.Constant(value0 - value1), ast.Sub(), right
                                )
                    case (_, ast.Constant()):
                        match op:
                            case ast.Add():
                                return ast.BinOp(right, op, left)
                            case _:
                                return ast.BinOp(left, op, right)
                    case _:
                        return ast.BinOp(left, op, right)

    def pe_stmt(self, s: ast.stmt):
        match s:
            case ast.Expr(ast.Call(ast.Name("print"), [expr])):
                return ast.Expr(ast.Call(ast.Name("print"), [self.pe_exp(expr)], []))
            case ast.Expr(expr):
                return ast.Expr(self.pe_exp(expr))
            case ast.Assign([ast.Name() as name], expr):
                return ast.Assign([name], self.pe_exp(expr))

    def partial_eval(self, p: ast.Module):
        match p:
            case ast.Module(body):
                return ast.Module([self.pe_stmt(stmt) for stmt in body])

    ############################################################################
    # Remove Complex Operands
    ############################################################################

    def rco_exp(self, e: ast.expr, need_atomic: bool) -> Tuple[ast.expr, Temporaries]:
        match e:
            case ast.Constant() | ast.Name():
                return (e, [])

            case ast.UnaryOp(ast.USub(), expr):
                atm, temporaries = self.rco_exp(expr, True)
                new_expr = ast.UnaryOp(ast.USub(), atm)
                if need_atomic:
                    new_var = ast.Name(generate_name("tmp"))
                    return (new_var, [*temporaries, (new_var, new_expr)])
                return (new_expr, temporaries)

            case ast.BinOp(left, (ast.Add() | ast.Sub()) as op, right):
                left_atm, left_temporaries = self.rco_exp(left, True)
                right_atm, right_temporaries = self.rco_exp(right, True)
                new_expr = ast.BinOp(left_atm, op, right_atm)
                if need_atomic:
                    new_var = ast.Name(generate_name("tmp"))
                    return (
                        new_var,
                        [*left_temporaries, *right_temporaries, (new_var, new_expr)],
                    )
                return (new_expr, [*left_temporaries, *right_temporaries])

            case ast.Call(ast.Name("input_int"), []):
                if need_atomic:
                    new_var = ast.Name(generate_name("tmp"))
                    return (new_var, [(new_var, e)])
                return (e, [])

    def rco_stmt(self, s: ast.stmt) -> List[ast.stmt]:
        match s:
            case ast.Expr(ast.Call(ast.Name("print"), [expr])):
                atm, temporaries = self.rco_exp(expr, True)
                assigns = [ast.Assign([name], exp) for name, exp in temporaries]
                new_expr = ast.Expr(ast.Call(ast.Name("print"), [atm]))
                return [*assigns, new_expr]

            case ast.Expr(value):
                expr, temporaries = self.rco_exp(value, False)
                assigns = [ast.Assign([name], exp) for name, exp in temporaries]
                new_expr = ast.Expr(expr)
                return [*assigns, new_expr]

            case ast.Assign([ast.Name(var)], expr):
                expr, temporaries = self.rco_exp(expr, False)
                assigns = [ast.Assign([name], exp) for name, exp in temporaries]
                new_expr = ast.Assign([ast.Name(var)], expr)
                return [*assigns, new_expr]

    def remove_complex_operands(self, p: ast.Module) -> ast.Module:
        match p:
            case ast.Module(body):
                new_body = []
                for stmt in body:
                    stmts = self.rco_stmt(stmt)
                    new_body = [*new_body, *stmts]
                return ast.Module(new_body)

    ############################################################################
    # Select Instructions
    ############################################################################

    # The expression e passed to select_arg should furthermore be an atom.
    # (But there is no type for atoms, so the type of e is given as expr.)
    def select_arg(self, e: ast.expr) -> arg:
        match e:
            case ast.Name(var):
                return Variable(var)
            case ast.Constant(value):
                return Immediate(value)

    def select_stmt(self, s: ast.stmt) -> List[instr]:
        match s:
            case ast.Expr(ast.Call(ast.Name("print"), [atm])):
                arg = self.select_arg(atm)
                return [
                    Instr("movq", [arg, Reg("rdi")]),
                    Callq("print_int", 1),
                ]
            case ast.Expr(ast.Call(ast.Name("input_int"), [])):
                return [
                    Callq("read_int", 0),
                    Instr("movq", [Reg("rax"), target]),
                ]
            case ast.Expr():
                return []
            case ast.Assign([ast.Name(var)], exp):
                target = Variable(var)
                match exp:
                    case ast.Constant(value):
                        return [Instr("movq", [Immediate(value), target])]
                    case ast.Name(var):
                        source = Variable(var)
                        return [Instr("movq", [source, target])]
                    case ast.Call(ast.Name("input_int"), []):
                        return [
                            Callq("read_int", 0),
                            Instr("movq", [Reg("rax"), target]),
                        ]
                    case ast.UnaryOp(ast.USub(), atm):
                        arg = self.select_arg(atm)
                        match arg:
                            case Immediate() | Variable():
                                return [
                                    Instr("movq", [arg, target]),
                                    Instr("negq", [target]),
                                ]

                    case ast.BinOp(left_atm, (ast.Add() | ast.Sub()) as op, right_atm):
                        arg0 = self.select_arg(left_atm)
                        arg1 = self.select_arg(right_atm)
                        instr_name = None
                        match op:
                            case ast.Add():
                                instr_name = "addq"
                            case ast.Sub():
                                instr_name = "subq"

                        match (arg0, arg1):
                            case (Variable(var_arg), other) if var_arg == var:
                                return [Instr(instr_name, [other, target])]
                            case (other, Variable(var_arg)) if var_arg == var:
                                return [Instr(instr_name, [other, target])]
                            case _:
                                return [
                                    Instr("movq", [arg0, target]),
                                    Instr(instr_name, [arg1, target]),
                                ]
            case _:
                raise Exception("E")

    def select_instructions(self, p: ast.Module) -> X86Program:
        match p:
            case ast.Module(body):
                program = []
                for stmt in body:
                    program = [*program, *self.select_stmt(stmt)]
                return X86Program(program, 0)

    ############################################################################
    # Liveness analysys
    ############################################################################

    def compute_locations(self, a: arg) -> Set[location]:
        match a:
            case Reg() | Deref() | Variable():
                return set([a])
            case _:
                return set()

    def compute_R(self, i: instr) -> Set[location]:
        # set of locations instruction read from
        match i:
            case Instr("movq", [arg0, arg1]):
                return self.compute_locations(arg0)
            case Instr(_, [arg0, arg1]):
                locs0 = self.compute_locations(arg0)
                locs1 = self.compute_locations(arg1)
                return locs0.union(locs1)
            case Instr("negq" | "pushq", [arg0]):
                return self.compute_locations(arg0)
            case Callq(_, num_args):
                return {0: set(), 1: set([Reg("rdi")])}[num_args]
            case _:
                return set()

    def compute_W(self, i: instr) -> Set[location]:
        # set of locations instruction write to
        match i:
            case Instr(_, [arg0, arg1]):
                return self.compute_locations(arg1)
            case Instr("negq" | "popq", [arg0]):
                return self.compute_locations(arg0)
            case Callq():
                return set(
                    [
                        Reg("rax"),
                        Reg("rcx"),
                        Reg("rdx"),
                        Reg("rsi"),
                        Reg("rdi"),
                        Reg("r8"),
                        Reg("r9"),
                        Reg("r10"),
                        Reg("r11"),
                    ]
                )
            case _:
                return set()

    def uncover_live(self, p: X86Program) -> Dict[instr, Set[location]]:
        match p:
            case X86Program(list() as body):
                mapping = {}
                l_after = set()
                for instr in reversed(body):
                    mapping[instr] = l_after
                    read = self.compute_R(instr)
                    write = self.compute_W(instr)
                    l_before = l_after.difference(write).union(read)
                    l_after = l_before
                return mapping

    ############################################################################
    # Building interference graph
    ############################################################################

    def build_interference(self, p: X86Program) -> UndirectedAdjList:
        match p:
            case X86Program(list() as body):
                liveness = self.uncover_live(p)
                graph = UndirectedAdjList(
                    vertex_label=lambda x: (
                        str(x) if not str(x).startswith("%") else f"\{x}"
                    )
                )
                for instr in body:
                    live_after = liveness[instr]
                    locations = self.compute_R(instr).union(self.compute_W(instr))
                    for loc in locations:
                        graph.add_vertex(loc)

                    match instr:
                        case Instr("movq", [s, d]):
                            for v in live_after:
                                if v != s and v != d:
                                    graph.add_edge(d, v)
                        case _:
                            write_to = self.compute_W(instr)
                            for d in write_to:
                                for v in live_after:
                                    if v != d:
                                        graph.add_edge(d, v)
                return graph

    def color_graph(
        self, graph: UndirectedAdjList, vars: List[Variable]
    ) -> Dict[Variable, int]:
        color_mapping = {}
        saturations = {}

        register_to_integer = {
            "rcx": 0,
            "rdx": 1,
            "rsi": 2,
            "rdi": 3,
            "r8": 4,
            "r9": 5,
            "r10": 6,
            "rbx": 7,
            "r12": 8,
            "r13": 9,
            "r14": 10,
            "rax": -1,
            "rsp": -2,
            "rbp": -3,
            "r11": -4,
            "r15": -5,
        }

        def less(x, y):
            return len(saturations[x.key]) < len(saturations[y.key])

        queue = PriorityQueue(less)
        for var in vars:
            saturation = set()
            adjacent_vertices = graph.adjacent(var)
            for v in adjacent_vertices:
                match v:
                    case Reg(reg):
                        saturation.add(register_to_integer[reg])

            saturations[var] = saturation
            queue.push(var)

        def lowest_available_color(alredy_used_colors: List[int]):
            color = 0
            while color in alredy_used_colors:
                color += 1
            return color

        while not queue.empty():
            vertex = queue.pop()
            reserved = saturations[vertex]
            color = lowest_available_color(reserved)
            color_mapping[vertex] = color
            adjacent_vertices = graph.adjacent(vertex)
            for adjacent_vertex in adjacent_vertices:
                match adjacent_vertex:
                    case Variable():
                        saturations[adjacent_vertex].add(color)
                        queue.increase_key(adjacent_vertex)
        return color_mapping

    ############################################################################
    # Assign Homes
    ############################################################################

    def assign_homes_arg(
        self, a: arg, home: Dict[Variable, int], available: int
    ) -> arg:
        match a:
            case Variable():
                integer_to_register = {
                    0: "rcx",
                    1: "rdx",
                    2: "rsi",
                    3: "rdi",
                    4: "r8",
                    5: "r9",
                    6: "r10",
                    7: "rbx",
                    8: "r12",
                    9: "r13",
                    10: "r14",
                }
                mapped = home[a]
                if mapped < available:
                    return Reg(integer_to_register[mapped])
                else:
                    return Deref("rbp", -8 * (mapped - available + 1))
            case _:
                return a

    def assign_homes_instr(
        self, i: instr, home: Dict[Variable, int], available: int
    ) -> instr:
        match i:
            case Instr(cmd, [arg0, arg1]):
                arg0 = self.assign_homes_arg(arg0, home, available)
                arg1 = self.assign_homes_arg(arg1, home, available)
                return Instr(cmd, [arg0, arg1])
            case Instr(cmd, [arg0]):
                arg0 = self.assign_homes_arg(arg0, home, available)
                return Instr(cmd, [arg0])
            case _:
                return i

    def assign_homes(self, p: X86Program, available: int = 11) -> X86Program:
        match p:
            case X86Program(list() as body):
                interference_graph = self.build_interference(p)
                variables = [
                    loc
                    for loc in interference_graph.vertices()
                    if isinstance(loc, Variable)
                ]
                home = self.color_graph(interference_graph, variables)
                new_body = [
                    self.assign_homes_instr(instr, home, available) for instr in body
                ]
                colors = home.values()
                used_callee = [Reg("rbp")]
                if len(colors) > 0:
                    stack_size = max(max(colors) - available + 1, 0) * 8
                    calee_saved_registers = [
                        Reg("rbx"),
                        Reg("r12"),
                        Reg("r13"),
                        Reg("r14"),
                    ]
                    used_callee.extend(calee_saved_registers[: max(max(colors) - 6, 0)])
                else:
                    stack_size = 0
                return X86Program(new_body, stack_size, used_callee)

    ############################################################################
    # Patch Instructions
    ############################################################################

    def patch_instr(self, i: instr) -> List[instr]:
        match i:
            case Instr("movq", [arg0, arg1]):
                if arg0 == arg1:
                    return []
                match (arg0, arg1):
                    case (Deref(), Deref()):
                        return [
                            Instr("movq", [arg0, Reg("rax")]),
                            Instr("movq", [Reg("rax"), arg1]),
                        ]
                    case (Immediate(value), Deref()) if value > 2**16:
                        return [
                            Instr("movq", [arg0, Reg("rax")]),
                            Instr("movq", [Reg("rax"), arg1]),
                        ]
                    case _:
                        return [i]
            case Instr(cmd, [arg0, arg1]):
                match (arg0, arg1):
                    case (Deref(), Deref()):
                        return [
                            Instr("movq", [arg1, Reg("rax")]),
                            Instr(cmd, [arg0, Reg("rax")]),
                            Instr("movq", [Reg("rax"), arg1]),
                        ]
                    case (Immediate(value), Deref()) if value > 2**16:
                        return [
                            Instr("movq", [arg0, Reg("rax")]),
                            Instr(cmd, [Reg("rax"), arg1]),
                        ]
                    case _:
                        return [i]
            case _:
                return [i]

    def patch_instructions(self, p: X86Program) -> X86Program:
        match p:
            case X86Program(list() as body, stack_space, used_callee):
                new_body = []
                for instr in body:
                    new_body = [*new_body, *self.patch_instr(instr)]
                return X86Program(new_body, stack_space, used_callee)

    ############################################################################
    # Prelude & Conclusion
    ############################################################################

    def prelude_and_conclusion(self, p: X86Program) -> X86Program:
        match p:
            case X86Program(list() as body, stack_space, used_callee):

                align = lambda x: x + 8 if x % 16 != 0 else x
                used_by_callee = len(used_callee) * 8 - 8
                stack_space = align(stack_space + used_by_callee) - used_by_callee
                if stack_space != 0:
                    return X86Program(
                        [
                            *[
                                Instr("pushq", [callee_saved_reg])
                                for callee_saved_reg in used_callee
                            ],
                            Instr("movq", [Reg("rsp"), Reg("rbp")]),
                            Instr("subq", [Immediate(stack_space), Reg("rsp")]),
                            *body,
                            Instr("addq", [Immediate(stack_space), Reg("rsp")]),
                            *[
                                Instr("popq", [callee_saved_reg])
                                for callee_saved_reg in reversed(used_callee)
                            ],
                            Instr("retq", []),
                        ],
                        stack_space,
                    )
                else:
                    return X86Program(
                        [
                            Instr("pushq", [Reg("rbp")]),
                            Instr("movq", [Reg("rsp"), Reg("rbp")]),
                            *body,
                            Instr("popq", [Reg("rbp")]),
                            Instr("retq", []),
                        ],
                        stack_space,
                    )
