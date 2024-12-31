import ast
from ast import *
from utils import *
from x86_ast import *
import os
from typing import List, Tuple, Set, Dict

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
                return X86Program(program)

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

    def uncover_live(self, p: X86Program) -> Dict[instr, Set[Variable]]:
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
    # Assign Homes
    ############################################################################

    def assign_homes_arg(self, a: arg, home: Dict[Variable, arg]) -> arg:
        match a:
            case Variable():
                if a in home:
                    return home[a]

                allocated = len(home)
                new_home = Deref("rbp", -8 * (allocated + 1))
                home[a] = new_home
                return new_home
            case _:
                return a

    def assign_homes_instr(self, i: instr, home: Dict[Variable, arg]) -> instr:
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
            case X86Program(list() as body):
                home = {}
                new_body = [self.assign_homes_instr(instr, home) for instr in body]
                stack_size = len(home) * 8
                return X86Program(new_body, stack_size)

    ############################################################################
    # Patch Instructions
    ############################################################################

    def patch_instr(self, i: instr) -> List[instr]:
        match i:
            case Instr("movq", [arg0, arg1]):
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
            case X86Program(list() as body, stack_space):
                new_body = []
                for instr in body:
                    new_body = [*new_body, *self.patch_instr(instr)]
                return X86Program(new_body, stack_space)

    ############################################################################
    # Prelude & Conclusion
    ############################################################################

    def prelude_and_conclusion(self, p: X86Program) -> X86Program:
        match p:
            case X86Program(list() as body, stack_space):
                if (stack_space) % 16 != 0:
                    stack_space += 8

                return X86Program(
                    [
                        Instr("pushq", [Reg("rbp")]),
                        Instr("movq", [Reg("rsp"), Reg("rbp")]),
                        Instr("subq", [Immediate(stack_space), Reg("rsp")]),
                        *body,
                        Instr("addq", [Immediate(stack_space), Reg("rsp")]),
                        Instr("popq", [Reg("rbp")]),
                        Instr("retq", []),
                    ],
                    stack_space,
                )
