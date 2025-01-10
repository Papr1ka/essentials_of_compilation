import ast
from ast import *
from graph import UndirectedAdjList, DirectedAdjList, topological_sort, transpose
from utils import *
from x86_ast import *
import os
from typing import Any, List, Tuple, Set, Dict
from priority_queue import PriorityQueue


@dataclass
class Promise:
    fun: Any
    cache: list[stmt] = None

    def force(self):
        if self.cache is None:
            self.cache = self.fun()
        return self.cache


def force(promise: list[stmt] | Promise) -> list[stmt]:
    if isinstance(promise, Promise):
        return promise.force()
    return promise


# def create_block(stmts, basic_blocks) -> List[stmt]:
#     match stmts:
#         case [Goto(l)]:
#             return stmts
#         case _:
#             label = label_name(generate_name("block"))
#             basic_blocks[label] = stmts
#             return [Goto(label)]


def create_block(
    promise: list[stmt] | Promise, basic_blocks: dict[str, list[stmt]]
) -> Promise:
    def delay():
        stmts = force(promise)
        match stmts:
            case [Goto(l)]:
                return stmts
            case _:
                label = label_name(generate_name("block"))
                basic_blocks[label] = stmts
                return [Goto(label)]

    return Promise(delay)


Binding = Tuple[Name, expr]
Temporaries = List[Binding]
LazySS = Promise | list[stmt]


cmd_to_cc_mapping = {
    Eq: "e",
    NotEq: "ne",
    Lt: "l",
    LtE: "le",
    Gt: "g",
    GtE: "ge",
}


class Compiler:
    def __init__(self, available: int = 11):
        self.available = available

    ############################################################################
    # Partial Evaluation
    ############################################################################

    def shrink_exp(self, e: expr):
        match e:
            case ast.UnaryOp(ast.USub() | ast.Not() as op, exp):
                return ast.UnaryOp(op, self.shrink_exp(exp))
            case ast.BinOp(left, ast.Add() | ast.Sub() as op, right):
                return ast.BinOp(self.shrink_exp(left), op, self.shrink_exp(right))
            case ast.BoolOp(ast.And(), [left, right]):
                left = self.shrink_exp(left)
                right = self.shrink_exp(right)
                return ast.IfExp(left, right, ast.Constant(False))
            case ast.BoolOp(ast.Or(), [left, right]):
                left = self.shrink_exp(left)
                right = self.shrink_exp(right)
                return ast.IfExp(left, ast.Constant(True), right)
            case ast.Compare(left, [cmp], [right]):
                return ast.Compare(
                    self.shrink_exp(left), [cmp], [self.shrink_exp(right)]
                )
            case ast.IfExp(exp, body, orelse):
                return ast.IfExp(
                    self.shrink_exp(exp), self.shrink_exp(body), self.shrink_exp(orelse)
                )
            case _:
                return e

    def shrink_stmt(self, s: stmt):
        match s:
            case ast.Expr(ast.Call(ast.Name("print"), [exp])):
                return ast.Expr(ast.Call(ast.Name("print"), [self.shrink_exp(exp)]))
            case ast.Expr(exp):
                return ast.Expr(self.shrink_exp(exp))
            case ast.Assign([ast.Name() as name], exp):
                return ast.Assign([name], self.shrink_exp(exp))
            case ast.If(exp, body_stmts, orelse_stmts):
                return ast.If(
                    self.shrink_exp(exp),
                    [self.shrink_stmt(stmt) for stmt in body_stmts],
                    [self.shrink_stmt(stmt) for stmt in orelse_stmts],
                )
            case _:
                return s

    def shrink(self, p: ast.Module):
        match p:
            case ast.Module(list() as body):
                return ast.Module([self.shrink_stmt(stmt) for stmt in body])

    # def pe_exp(self, e: ast.expr):
    #     match e:
    #         case ast.Constant(int()) | ast.Call(ast.Name("input_int"), []) | ast.Name():
    #             return e
    #         case ast.UnaryOp(ast.USub(), expr):
    #             expr = self.pe_exp(expr)
    #             match expr:
    #                 case ast.Constant(value):
    #                     return ast.Constant(neg64(value))
    #                 case _:
    #                     return ast.UnaryOp(ast.USub(), expr)

    #         case ast.BinOp(left, (ast.Add() | ast.Sub()) as op, right):
    #             left = self.pe_exp(left)
    #             right = self.pe_exp(right)

    #             match (left, right):
    #                 case (ast.Constant(value0), ast.Constant(value1)):
    #                     match op:
    #                         case ast.Add():
    #                             return ast.Constant(add64(value0, value1))
    #                         case ast.Sub():
    #                             return ast.Constant(sub64(value0, value1))
    #                 case (
    #                     ast.BinOp(ast.Constant(value0), ast.Add(), right),
    #                     ast.Constant(value1),
    #                 ):
    #                     match op:
    #                         case ast.Add():
    #                             return ast.BinOp(
    #                                 ast.Constant(value0 + value1), ast.Add(), right
    #                             )
    #                         case ast.Sub():
    #                             return ast.BinOp(
    #                                 ast.Constant(value0 - value1), ast.Add(), right
    #                             )
    #                 case (
    #                     ast.Constant(value0),
    #                     ast.BinOp(ast.Constant(value1), ast.Add(), right),
    #                 ):
    #                     match op:
    #                         case ast.Add():
    #                             return ast.BinOp(
    #                                 ast.Constant(value0 + value1), ast.Add(), right
    #                             )
    #                         case ast.Sub():
    #                             return ast.BinOp(
    #                                 ast.Constant(value0 - value1), ast.Sub(), right
    #                             )
    #                 case (_, ast.Constant()):
    #                     match op:
    #                         case ast.Add():
    #                             return ast.BinOp(right, op, left)
    #                         case _:
    #                             return ast.BinOp(left, op, right)
    #                 case _:
    #                     return ast.BinOp(left, op, right)
    #         case _:
    #             return e

    # def pe_stmt(self, s: ast.stmt):
    #     match s:
    #         case ast.Expr(ast.Call(ast.Name("print"), [expr])):
    #             return ast.Expr(ast.Call(ast.Name("print"), [self.pe_exp(expr)], []))
    #         case ast.Expr(expr):
    #             return ast.Expr(self.pe_exp(expr))
    #         case ast.Assign([ast.Name() as name], expr):
    #             return ast.Assign([name], self.pe_exp(expr))
    #         case _:
    #             return s

    # def partial_eval(self, p: ast.Module):
    #     match p:
    #         case ast.Module(body):
    #             return ast.Module([self.pe_stmt(stmt) for stmt in body])

    # ############################################################################
    # # Remove Complex Operands
    # ############################################################################

    def rco_exp(self, e: ast.expr, need_atomic: bool) -> Tuple[ast.expr, Temporaries]:
        match e:
            case ast.Constant() | ast.Name():
                return (e, [])

            case ast.UnaryOp((ast.USub() | ast.Not()) as op, expr):
                atm, temporaries = self.rco_exp(expr, True)
                new_expr = ast.UnaryOp(op, atm)
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

            case ast.Compare(left, [cmp], [right]):
                left_atm, left_temporaries = self.rco_exp(left, True)
                right_atm, right_temporaries = self.rco_exp(right, True)
                new_expr = ast.Compare(left_atm, [cmp], [right_atm])
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

            case ast.IfExp(test, body, orelse):
                test, test_temporaries = self.rco_exp(test, False)
                body, body_temporaries = self.rco_exp(body, False)
                orelse, orelse_temporaries = self.rco_exp(orelse, False)

                body_assigns = [
                    ast.Assign([name], exp) for name, exp in body_temporaries
                ]
                orelse_assigns = [
                    ast.Assign([name], exp) for name, exp in orelse_temporaries
                ]
                new_body_expr = Begin(body_assigns, body)
                new_orelse_expr = Begin(orelse_assigns, orelse)
                new_expr = ast.IfExp(test, new_body_expr, new_orelse_expr)

                if need_atomic:
                    new_var = ast.Name(generate_name("tmp"))
                    return (new_var, [*test_temporaries, (new_var, new_expr)])
                return (new_expr, test_temporaries)
            case _:
                raise Exception(type(e))

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

            case ast.If(test, list() as body, list() as orelse):
                expr, temporaries = self.rco_exp(test, False)
                assigns = [ast.Assign([name], exp) for name, exp in temporaries]

                new_body = []
                for stmt in body:
                    new_body = [*new_body, *self.rco_stmt(stmt)]
                new_orelse = []
                for stmt in orelse:
                    new_orelse = [*new_orelse, *self.rco_stmt(stmt)]
                new_expr = ast.If(expr, new_body, new_orelse)
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
    # Explicate control
    ############################################################################

    def explicate_effect(
        self, e: expr, cont: LazySS, basic_blocks: dict[str, list[stmt]]
    ) -> LazySS:
        match e:
            case IfExp(test, body, orelse):
                next_block = create_block(cont, basic_blocks)
                new_body = self.explicate_effect(body, next_block, basic_blocks)
                new_orelse = self.explicate_effect(orelse, next_block, basic_blocks)
                return Promise(
                    lambda: self.explicate_pred(
                        test, new_body, new_orelse, basic_blocks
                    )
                    + force(cont)
                )
            case Call(Name("input_int"), []):
                return Promise(lambda: [Expr(e)] + force(cont))
            case Begin(body, result):
                new_body = self.explicate_effect(result, cont, basic_blocks)
                for stmt in reversed(body):
                    new_body = self.explicate_stmt(stmt, new_body, basic_blocks)
                return new_body
            case _:
                return Promise(lambda: force(cont))

    def explicate_assign(
        self,
        rhs: expr,
        lhs: Name,
        cont: LazySS,
        basic_blocks: dict[str, list[stmt]],
    ) -> LazySS:
        match rhs:
            case IfExp(test, body, orelse):
                next_block = create_block(cont, basic_blocks)
                new_body = self.explicate_assign(body, lhs, next_block, basic_blocks)
                new_orelse = self.explicate_assign(
                    orelse, lhs, next_block, basic_blocks
                )
                return self.explicate_pred(test, new_body, new_orelse, basic_blocks)

            case Begin(body, result):
                new_body = self.explicate_assign(result, lhs, cont, basic_blocks)
                for stmt in reversed(body):
                    new_body = self.explicate_stmt(stmt, new_body, basic_blocks)
                return new_body
            case _:
                return Promise(lambda: [Assign([lhs], rhs)] + force(cont))

    def explicate_pred(
        self,
        cnd: expr,
        thn: LazySS,
        els: LazySS,
        basic_blocks: dict[str, list[stmt]],
    ) -> LazySS:
        match cnd:
            case Compare(_, [_], [_]):
                goto_thn = create_block(thn, basic_blocks)
                goto_els = create_block(els, basic_blocks)
                return Promise(lambda: [If(cnd, force(goto_thn), force(goto_els))])
            case Constant(True):
                return thn
            case Constant(False):
                return els
            case UnaryOp(Not(), operand):
                return self.explicate_pred(operand, els, thn, basic_blocks)
            case IfExp(test, body, orelse):
                goto_thn = create_block(thn, basic_blocks)
                goto_els = create_block(els, basic_blocks)
                new_body = self.explicate_pred(body, goto_thn, goto_els, basic_blocks)
                new_orelse = self.explicate_pred(
                    orelse, goto_thn, goto_els, basic_blocks
                )
                return self.explicate_pred(test, new_body, new_orelse, basic_blocks)
            case Begin(body, result):
                new_body = self.explicate_pred(result, thn, els, basic_blocks)
                for stmt in reversed(body):
                    new_body = self.explicate_stmt(stmt, new_body, basic_blocks)
                return new_body
            case _:
                return Promise(
                    lambda: [
                        If(
                            Compare(cnd, [Eq()], [Constant(False)]),
                            force(create_block(els, basic_blocks)),
                            force(create_block(thn, basic_blocks)),
                        )
                    ]
                )

    def explicate_stmt(
        self, s: stmt, cont: LazySS, basic_blocks: dict[str, list[stmt]]
    ) -> LazySS:
        match s:
            case Assign([lhs], rhs):
                return self.explicate_assign(rhs, lhs, cont, basic_blocks)
            case Expr(Call(Name("print"), [_])):
                return Promise(lambda: [s] + force(cont))
            case Expr(value):
                return self.explicate_effect(value, cont, basic_blocks)
            case If(test, body, orelse):
                next_block = create_block(cont, basic_blocks)
                new_body = next_block
                for stmt in reversed(body):
                    new_body = self.explicate_stmt(stmt, new_body, basic_blocks)

                new_orelse = next_block
                for stmt in reversed(orelse):
                    new_orelse = self.explicate_stmt(stmt, new_orelse, basic_blocks)

                return self.explicate_pred(test, new_body, new_orelse, basic_blocks)

    def explicate_control(self, p):
        match p:
            case Module(body):
                new_body = [Return(Constant(0))]
                basic_blocks = {}
                for s in reversed(body):
                    new_body = force(self.explicate_stmt(s, new_body, basic_blocks))
                basic_blocks[label_name("start")] = new_body
                return CProgram(basic_blocks)

    ############################################################################
    # Select Instructions
    ############################################################################

    # The expression e passed to select_arg should furthermore be an atom.
    # (But there is no type for atoms, so the type of e is given as expr.)
    def select_arg(self, e: expr) -> arg:
        match e:
            case Name(var):
                return Variable(var)
            case Constant(bool() as val):
                return Immediate(int(val))
            case Constant(value):
                return Immediate(value)

    def select_exp(self, e: expr, target: None | Variable | Reg) -> list[instr]:
        if target is None:
            match e:
                case Call(Name("input_int"), []):
                    return [Callq("read_int", 0)]
                case _:
                    return []

        match e:
            case Name() | Constant():
                return [Instr("movq", [self.select_arg(e), target])]
            case Call(Name("input_int"), []):
                return [
                    Callq("read_int", 0),
                    Instr("movq", [Reg("rax"), target]),
                ]
            case UnaryOp(USub(), atm):
                return [
                    Instr("movq", [self.select_arg(atm), target]),
                    Instr("negq", [target]),
                ]
            case UnaryOp(Not(), atm):
                arg0 = self.select_arg(atm)
                match target, arg0:
                    case Variable(dest), Variable(source) if source == dest:
                        return [Instr("xorq", [Immediate(1), target])]
                    case _:
                        return [
                            Instr("movq", [arg0, target]),
                            Instr("xorq", [Immediate(1), target]),
                        ]

            case BinOp(left, (Add() | Sub()) as op, right):
                arg0 = self.select_arg(left)
                arg1 = self.select_arg(right)
                instr_name = None
                match op:
                    case ast.Add():
                        instr_name = "addq"
                    case ast.Sub():
                        instr_name = "subq"

                match target:
                    case Reg():
                        return [
                            Instr("movq", [arg0, target]),
                            Instr(instr_name, [arg1, target]),
                        ]
                    case Variable(var):
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
            case Compare(left, [cmp], [right]):
                arg0 = self.select_arg(left)
                arg1 = self.select_arg(right)
                cc = cmd_to_cc_mapping[type(cmp)]
                return [
                    Instr("cmpq", [arg1, arg0]),
                    Instr(f"set{cc}", [ByteReg("al")]),
                    Instr("movzbq", [ByteReg("al"), target]),
                ]
            case _:
                raise Exception(f"not supported expression: {e}")

    def select_stmt(self, s: stmt) -> List[instr]:
        match s:
            case Expr(Call(Name("print"), [atm])):
                arg = self.select_arg(atm)
                return [
                    Instr("movq", [arg, Reg("rdi")]),
                    Callq("print_int", 1),
                ]
            case Expr(exp):
                return self.select_exp(exp)
            case Assign([Name(var)], exp):
                target = Variable(var)
                return self.select_exp(exp, target)
            case _:
                raise Exception("E")

    def select_tail(self, t: stmt) -> list[instr]:
        match t:
            case Return(value):
                return [
                    *self.select_exp(value, Reg("rax")),
                    Jump(label_name("conclusion")),
                ]
            case Goto(label):
                return [Jump(label)]
            case If(
                Compare(left, [cmp], [right]),
                [Goto(label_thn)],
                [Goto(label_els)],
            ):
                arg0 = self.select_arg(left)
                arg1 = self.select_arg(right)
                cc = cmd_to_cc_mapping[type(cmp)]
                return [
                    Instr("cmpq", [arg1, arg0]),
                    JumpIf(cc, label_thn),
                    Jump(label_els),
                ]

    def select_instructions(self, p: CProgram) -> X86Program:
        match p:
            case CProgram(basic_blocks):
                x86_basic_blocks = {label_name("conclusion"): []}
                for label, (*ss, tail) in basic_blocks.items():
                    block = []
                    for stmt in ss:
                        block += self.select_stmt(stmt)
                    block += self.select_tail(tail)
                    x86_basic_blocks[label] = block
                return X86Program(x86_basic_blocks, 0)

    ############################################################################
    # Liveness analysys
    ############################################################################

    def build_cfg_block(
        self, block_label: str, block: list[instr], graph: DirectedAdjList
    ):
        for instr in block:
            match instr:
                case Jump(label):
                    graph.add_edge(block_label, label)
                case JumpIf(_, label):
                    graph.add_edge(block_label, label)

    def build_cfg(self, p: X86Program) -> DirectedAdjList:
        match p:
            case X86Program(basic_blocks):
                graph = DirectedAdjList()
                for label, block in basic_blocks.items():
                    graph.add_vertex(label)
                    self.build_cfg_block(label, block, graph)
                return graph

    def compute_locations(self, a: arg) -> Set[location]:
        match a:
            case Reg() | Deref() | Variable() | ByteReg():
                return set([a])
            case _:
                return set()

    def compute_R(self, i: instr) -> Set[location]:
        # set of locations instruction read from
        match i:
            case Instr("movq" | "movzbq", [arg0, arg1]):
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
            case Instr("cmpq", [arg0, arg1]):
                return set()
            case Instr(_, [arg0, arg1]):
                return self.compute_locations(arg1)
            case Instr("negq" | "popq", [arg0]):
                return self.compute_locations(arg0)
            case Instr(str(instr), [arg0]) if instr.startswith("set"):
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

    def uncover_live_block(
        self,
        block: list[stmt],
        mapping: dict[instr, set[location]],
        live_before_block: dict[str, set[location]],
    ) -> set[location]:
        l_after = set()
        l_before = l_after
        for instr in reversed(block):
            mapping[instr] = l_after

            match instr:
                case Jump(label):
                    l_before = live_before_block[label]
                case JumpIf(_, label):
                    l_before = live_before_block[label].union(l_before)
                case _:
                    read = self.compute_R(instr)
                    write = self.compute_W(instr)
                    l_before = l_after.difference(write).union(read)

            l_after = l_before
        return l_before

    def uncover_live(self, p: X86Program) -> Dict[instr, Set[location]]:
        match p:
            case X86Program(dict() as basic_blocks):
                cfg = self.build_cfg(p)
                transposed_cfg = transpose(cfg)
                ordering: list[str] = topological_sort(transposed_cfg)
                live_before_block = {}

                mapping = {}
                for block_label in ordering:
                    block = basic_blocks[block_label]
                    l_before = self.uncover_live_block(
                        block, mapping, live_before_block
                    )
                    live_before_block[block_label] = l_before
                return mapping

    ############################################################################
    # Collect all variables
    ############################################################################

    def collect_vars_arg(self, a: arg) -> list[Variable]:
        match a:
            case Variable():
                return [a]
            case _:
                return []

    def collect_vars_instr(self, i: instr):
        match i:
            case Instr(_, [arg0, arg1]):
                return self.collect_vars_arg(arg0) + self.collect_vars_arg(arg1)
            case Instr(_, [arg0]):
                return self.collect_vars_arg(arg0)
            case _:
                return []

    def collect_vars(self, p: X86Program) -> List[Variable]:
        match p:
            case X86Program(dict() as basic_blocks):
                variables = set()
                for block in basic_blocks.values():
                    for instr in block:
                        variables = variables.union(self.collect_vars_instr(instr))
                return variables

    ############################################################################
    # Building interference graph
    ############################################################################

    def build_interference(self, p: X86Program) -> UndirectedAdjList:
        match p:
            case X86Program(dict() as basic_blocks):
                liveness = self.uncover_live(p)
                graph = UndirectedAdjList(
                    vertex_label=lambda x: (
                        str(x) if not str(x).startswith("%") else f"\\{x}"
                    )
                )

                for block in basic_blocks.values():
                    for instr in block:
                        live_after = liveness[instr]

                        match instr:
                            case Instr("movq" | "movzbq", [s, d]):
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

    def build_move_graph(self, p: X86Program) -> UndirectedAdjList:
        match p:
            case X86Program(dict() as basic_blocks):
                graph = UndirectedAdjList()
                for block in basic_blocks.values():
                    for instr in block:
                        match instr:
                            case Instr("movq", [Variable() as s, Variable() as d]):
                                graph.add_edge(s, d)
                return graph

    def color_graph(
        self,
        graph: UndirectedAdjList,
        vars: Iterable[Variable],
        move_graph: UndirectedAdjList,
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
            "al": -1,
        }

        def lowest_available_color(alredy_used_colors: List[int]):
            color = 0
            while color in alredy_used_colors:
                color += 1
            return color

        def available_move_related_color(x) -> int | None:
            not_available = saturations[x]
            related = move_graph.adjacent(x)
            move_related_colors = [
                color_mapping[var] for var in related if var in color_mapping
            ]
            min_available = lowest_available_color(not_available)
            is_on_stack = lambda x: x >= self.available
            is_on_reg = lambda x: x < self.available

            for color in move_related_colors:
                if color not in not_available and not (
                    is_on_reg(min_available) and is_on_stack(color)
                ):
                    return color

        def less(x, y):
            if len(saturations[x.key]) < len(saturations[y.key]):
                return True
            elif len(saturations[x.key]) == len(saturations[y.key]):
                return available_move_related_color(y.key) is not None
            else:
                return False

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

        while not queue.empty():
            vertex = queue.pop()
            reserved = saturations[vertex]

            available_color = available_move_related_color(vertex)
            if available_color is not None:
                color = available_color
            else:
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

    def assign_homes_arg(self, a: arg, home: Dict[Variable, int]) -> arg:
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
                if mapped < self.available:
                    return Reg(integer_to_register[mapped])
                else:
                    return Deref("rbp", -8 * (mapped - self.available + 1))
            case _:
                return a

    def assign_homes_instr(self, i: instr, home: Dict[Variable, int]) -> instr:
        match i:
            case Instr(cmd, [arg0, arg1]):
                arg0 = self.assign_homes_arg(arg0, home)
                arg1 = self.assign_homes_arg(arg1, home)
                return Instr(cmd, [arg0, arg1])
            case Instr(cmd, [arg0]):
                arg0 = self.assign_homes_arg(arg0, home)
                return Instr(cmd, [arg0])
            case _:
                return i

    def assign_homes(self, p: X86Program) -> X86Program:
        match p:
            case X86Program(dict() as basic_blocks):
                interference_graph = self.build_interference(p)
                variables = self.collect_vars(p)
                home = self.color_graph(
                    interference_graph, variables, self.build_move_graph(p)
                )
                new_blocks = {}
                for label, block in basic_blocks.items():
                    new_block_body = [
                        self.assign_homes_instr(instr, home) for instr in block
                    ]
                    new_blocks[label] = new_block_body

                colors = home.values()

                used_callee = [Reg("rbp")]
                if len(colors) > 0:
                    stack_size = max(max(colors) - self.available + 1, 0) * 8
                    calee_saved_registers = [
                        Reg("rbx"),
                        Reg("r12"),
                        Reg("r13"),
                        Reg("r14"),
                    ]
                    used_callee.extend(calee_saved_registers[: max(max(colors) - 6, 0)])
                else:
                    stack_size = 0
                return X86Program(new_blocks, stack_size, used_callee)

    ############################################################################
    # Patch Instructions
    ############################################################################

    def patch_instr(self, i: instr) -> List[instr]:
        match i:
            case Instr("cmpq", [arg0, arg1]):
                match (arg0, arg1):
                    case (Deref(), Deref()) | (_, Immediate()):
                        return [
                            Instr("movq", [arg1, Reg("rax")]),
                            Instr("cmpq", [arg0, Reg("rax")]),
                        ]
                    case (Immediate(value), Deref()) if value > 2**16:
                        return [
                            Instr("movq", [arg0, Reg("rax")]),
                            Instr("cmpq", [Reg("rax"), arg1]),
                        ]
                    case _:
                        return [i]
            case Instr("movzbq", [arg0, arg1]):
                match (arg0, arg1):
                    case (_, Reg()):
                        return [i]
                    case _:
                        return [
                            Instr("movzbq", [arg0, Reg("rax")]),
                            Instr("movq", [Reg("rax"), arg1]),
                        ]
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
            case X86Program(dict() as basic_blocks, stack_space, used_callee):
                new_blocks = {}
                for label, block in basic_blocks.items():
                    new_block_body = []
                    for instr in block:
                        new_block_body += self.patch_instr(instr)
                    new_blocks[label] = new_block_body
                return X86Program(new_blocks, stack_space, used_callee)

    ############################################################################
    # Prelude & Conclusion
    ############################################################################

    def prelude_and_conclusion(self, p: X86Program) -> X86Program:
        match p:
            case X86Program(dict() as basic_blocks, stack_space, used_callee):

                align = lambda x: x + 8 if x % 16 != 0 else x
                used_by_callee = len(used_callee) * 8 - 8
                stack_space = align(stack_space + used_by_callee) - used_by_callee
                prelude = [
                    *[
                        Instr("pushq", [callee_saved_reg])
                        for callee_saved_reg in used_callee
                    ],
                    Instr("movq", [Reg("rsp"), Reg("rbp")]),
                    Jump("start"),
                ]
                conclusion = [
                    *[
                        Instr("popq", [callee_saved_reg])
                        for callee_saved_reg in reversed(used_callee)
                    ],
                    Instr("retq", []),
                ]
                if stack_space != 0:
                    prelude.insert(
                        -1, Instr("subq", [Immediate(stack_space), Reg("rsp")])
                    )
                    conclusion.insert(
                        0, Instr("addq", [Immediate(stack_space), Reg("rsp")])
                    )

                basic_blocks[label_name("main")] = prelude
                basic_blocks[label_name("conclusion")] = conclusion

                return X86Program(basic_blocks, stack_space)
