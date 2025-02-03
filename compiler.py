from ast import *
from dataflow_analysis import analyze_dataflow
from graph import (
    UndirectedAdjList,
    DirectedAdjList,
    topological_stable_sort,
    transpose,
)
from utils import *
from x86_ast import *
import os
from typing import Any, Set, Dict
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


Binding = tuple[Name, expr]
Temporaries = list[Binding]
LazySS = Promise | list[stmt]


cmd_to_cc_mapping = {
    Eq: "e",
    NotEq: "ne",
    Lt: "l",
    LtE: "le",
    Gt: "g",
    GtE: "ge",
    Is: "e",
}

is_ptr = lambda x: not (isinstance(x, IntType) or isinstance(x, BoolType))
params_regs = ["rdi", "rsi", "rdx", "rcx", "r8", "r9"]

label_block_start = lambda name: label_name(name + "_start")
label_block_conclusion = lambda name: label_name(name + "_conclusion")
get_used_params_regs = lambda num_params: set(Reg(reg) for reg in params_regs[:num_params]) 

class Compiler:
    def __init__(
        self, available: int = 11, root_size: int = 65536, heap_size: int = 16
    ):
        self.available = available
        self.root_size = root_size
        self.heap_size = heap_size

    ############################################################################
    # Partial Evaluation
    ############################################################################

    def pe_exp(self, e: expr):
        match e:
            case Constant(int() | bool()) | Call(Name("input_int"), []) | Name():
                # int | boll | input_int() | var
                return e

            case UnaryOp(USub() | Not() as op, expr):
                # not e | -e
                expr = self.pe_exp(expr)
                match expr:
                    case Constant(value):
                        match op:
                            case USub():
                                # -int
                                return Constant(neg64(value))
                            case Not():
                                # not bool
                                return Constant(not value)
                    case _:
                        return UnaryOp(op, expr)

            case (
                BinOp(left, (Add() | Sub() | Mult()) as op, right)
                | BoolOp(op, [left, right])
                | Compare(left, [op], [right])
            ):
                # a +/- b, a and/or b, a cmp b
                left = self.pe_exp(left)
                right = self.pe_exp(right)

                match (left, right):
                    case (Constant(value0), Constant(value1)):
                        match op:
                            # binops (a +/-/* b)
                            case Add():
                                return Constant(add64(value0, value1))
                            case Sub():
                                return Constant(sub64(value0, value1))
                            case Mult():
                                return Constant(mul64(value0, value1))
                            # boolops (a and/or b)
                            case And():
                                return Constant(value0 and value1)
                            case Or():
                                return Constant(value0 or value1)
                            # cmp (a cmp b)
                            case Eq():
                                return Constant(value0 == value1)
                            case NotEq():
                                return Constant(value0 != value1)
                            case Lt():
                                return Constant(value0 < value1)
                            case LtE():
                                return Constant(value0 <= value1)
                            case Gt():
                                return Constant(value0 > value1)
                            case GtE():
                                return Constant(value0 >= value1)
                    case (
                        BinOp(
                            Constant(value0),
                            (Add() | Sub()) as inner_op,
                            right,
                        ),
                        Constant(value1),
                    ):
                        # (v0 +|- x) +|- v1
                        match op:
                            # binops (a +/- b)
                            case Add():
                                match inner_op:
                                    case Add():
                                        # (v0 + x) + v1 = (v0+v1) + x
                                        return BinOp(
                                            Constant(add64(value0, value1)),
                                            Add(),
                                            right,
                                        )
                                    case Sub():
                                        # (v0 - x) + v1 = (v0+v1) - x
                                        return BinOp(
                                            Constant(add64(value0, value1)),
                                            Sub(),
                                            right,
                                        )
                            case Sub():
                                match inner_op:
                                    case Add():
                                        # (v0 + x) - v1 = (v0-v1) + x
                                        return BinOp(
                                            Constant(sub64(value0, value1)),
                                            Add(),
                                            right,
                                        )
                                    case Sub():
                                        # (v0 - x) - v1 = (v0 - v1) - x
                                        return BinOp(
                                            Constant(sub64(value0 - value1)),
                                            Sub(),
                                            right,
                                        )
                            case And() | Or():
                                raise TypeError(
                                    f"type error, {left} must be bool in {left} {op} {right}"
                                )
                            case (Eq() | NotEq() | Gt() | GtE() | Lt() | LtE()) as cmp:
                                # ==, !=, >, >=, <, <=
                                match inner_op:
                                    case Add():
                                        # (v0 + x) cmp v1 = (x) cmp (v1 - v0)
                                        return Compare(
                                            right,
                                            [cmp],
                                            [Constant(sub64(value1, value0))],
                                        )
                                    case Sub():
                                        # (v0 - x) cmp v1 = (v0 - v1) cmp (x)
                                        return Compare(
                                            Constant(sub64(value0, value1)),
                                            [cmp],
                                            [right],
                                        )

                    case (
                        Constant(value0),
                        BinOp(Constant(value1), (Add() | Sub()) as inner_op, right),
                    ):
                        # v0 +/- (v1 +/- x)
                        match op:
                            case Add():
                                match inner_op:
                                    case Add():
                                        # v0 + (v1 + x) = (v0+v1) + x
                                        return BinOp(
                                            Constant(add64(value0, value1)),
                                            Add(),
                                            right,
                                        )
                                    case Sub():
                                        # v0 + (v1 - x) = (v0+v1) - x
                                        return BinOp(
                                            Constant(add64(value0, value1)),
                                            Sub(),
                                            right,
                                        )
                            case Sub():
                                match inner_op:
                                    case Add():
                                        # v0 - (v1 + x) = (v0-v1) - x
                                        return BinOp(
                                            Constant(sub64(value0, value1)),
                                            Sub(),
                                            right,
                                        )
                                    case Sub():
                                        # v0 - (v1 - x) = (v0-v1) + x
                                        return BinOp(
                                            Constant(sub64(value0, value1)),
                                            Add(),
                                            right,
                                        )
                            case And() | Or():
                                raise TypeError(
                                    f"type error, {left} must be bool in {left} {op} {right}"
                                )
                            case (Eq() | NotEq() | Gt() | GtE() | Lt() | LtE()) as cmp:
                                # ==, !=, >, >=, <, <=
                                match inner_op:
                                    case Add():
                                        # v0 cmp (v1 + x) = (v0-v1) cmp (x)
                                        return Compare(
                                            Constant(sub64(value0, value1)),
                                            [cmp],
                                            [right],
                                        )
                                    case Sub():
                                        # v0 cmp (v1 - x) = (x) cmp (v1-v0)
                                        return Compare(
                                            right,
                                            [cmp],
                                            [Constant(sub64(value1, value0))],
                                        )
                    case (Constant(bool() as value0), other) | (
                        other,
                        Constant(bool() as value0),
                    ):
                        match op:
                            case And():
                                match value0:
                                    case True:  # True and x | x and True
                                        return other
                                    case False if left.value is False:  # False and x
                                        return Constant(False)
                                    case False:  # x and False, side effects in x
                                        return other
                            case Or():
                                match value0:
                                    case True if left.value is True:  # True or x
                                        return Constant(True)
                                    case (
                                        True
                                    ):  # x or True, can't optimize, may be side effects in x
                                        return BoolOp(Or(), [left, right])
                                    case False:  # False or x | x or False
                                        return other
                            case Eq():
                                match value0:
                                    case True:  # True == x | x == True
                                        return other
                                    case False:  # False == x | x == False
                                        return UnaryOp(Not(), other)
                            case NotEq():
                                match value0:
                                    case True:  # True != x | x != True
                                        return UnaryOp(Not(), other)
                                    case False:  # False != x | x != False
                                        return other
                            case _:
                                raise TypeError(
                                    f"type error, {left} must be bool in {left} {op} {right}"
                                )
                    case (_, Constant(int())):
                        match op:
                            case Add():
                                return BinOp(right, op, left)
                            case _:
                                match e:
                                    case BinOp():
                                        return BinOp(left, op, right)
                                    case BoolOp():
                                        return BoolOp(op, [left, right])
                                    case Compare():
                                        return Compare(left, [op], [right])
                    case _:
                        match e:
                            case BinOp():
                                return BinOp(left, op, right)
                            case BoolOp():
                                return BoolOp(op, [left, right])
                            case Compare():
                                return Compare(left, [op], [right])

            case IfExp(test, body, orelse):
                test = self.pe_exp(test)
                match test:
                    case Constant(bool() as cond):
                        if cond:
                            return self.pe_exp(body)
                        return self.pe_exp(orelse)
                    case _:
                        return IfExp(test, self.pe_exp(body), self.pe_exp(orelse))
            case Call(exp, exps):
                return Call(self.pe_exp(exp), [self.pe_exp(e) for e in exps])
            case _:
                return e

    def pe_stmt(self, s: stmt) -> list[stmt]:
        match s:
            case Expr(Call(Name("print"), [expr])):
                return [Expr(Call(Name("print"), [self.pe_exp(expr)], []))]
            case Expr(expr):
                return [Expr(self.pe_exp(expr))]
            case Assign([lhs], rhs):
                return [Assign([self.pe_exp(lhs)], self.pe_exp(rhs))]
            case If(test, body, orelse):
                test = self.pe_exp(test)
                new_body = lambda: sum([self.pe_stmt(stmt) for stmt in body], [])
                new_orelse = lambda: sum([self.pe_stmt(stmt) for stmt in orelse], [])
                match test:
                    case Constant(bool() as cond):
                        if cond:
                            return new_body()
                        return new_orelse()
                    case _:
                        return [If(test, new_body(), new_orelse())]
            case While(test, body, []):
                test = self.pe_exp(test)
                new_body = sum([self.pe_stmt(stmt) for stmt in body], [])
                return [While(test, new_body, [])]
            case Return(expr):
                return [Return(self.pe_exp(expr))]
            case FunctionDef(name, args, f_body, decorator_list, returns, type_comment, type_params):
                return [
                    FunctionDef(name,
                                args,
                                sum([self.pe_stmt(stmt) for stmt in f_body], []),
                                decorator_list,
                                returns,
                                type_comment,
                                type_params)
                ]
            case _:
                return [s]

    def partial_eval(self, p: Module):
        match p:
            case Module(body):
                return Module(sum([self.pe_stmt(stmt) for stmt in body], []))

    ############################################################################
    # Shrink
    ############################################################################

    def shrink_exp(self, e: expr):
        match e:
            case UnaryOp(USub() | Not() as op, exp):
                return UnaryOp(op, self.shrink_exp(exp))
            case BinOp(left, Add() | Sub() | Mult() as op, right):
                return BinOp(self.shrink_exp(left), op, self.shrink_exp(right))
            case BoolOp(And(), [left, right]):
                left = self.shrink_exp(left)
                right = self.shrink_exp(right)
                return IfExp(left, right, Constant(False))
            case BoolOp(Or(), [left, right]):
                left = self.shrink_exp(left)
                right = self.shrink_exp(right)
                return IfExp(left, Constant(True), right)
            case BoolOp(op, [left, right]):
                return BoolOp(op, [self.shrink_exp(left), self.shrink_exp(right)])
            case Compare(left, [cmp], [right]):
                return Compare(self.shrink_exp(left), [cmp], [self.shrink_exp(right)])
            case IfExp(exp, body, orelse):
                return IfExp(
                    self.shrink_exp(exp), self.shrink_exp(body), self.shrink_exp(orelse)
                )
            case Tuple(elts, Load()):
                return Tuple([self.shrink_exp(e) for e in elts], Load())
            case Subscript(lhs, index, Load()):
                return Subscript(self.shrink_exp(lhs), self.shrink_exp(index), Load())
            case List(elts, Load()):
                return List([self.shrink_exp(e) for e in elts], Load())
            case Call(Name("len"), [exp]):
                return Call(Name("len"), [self.shrink_exp(exp)])
            case Call(exp, exps):
                return Call(self.shrink_exp(exp), [self.shrink_exp(e) for e in exps])
            case _:
                return e

    def shrink_stmt(self, s: stmt):
        match s:
            case Expr(Call(Name("print"), [exp])):
                return Expr(Call(Name("print"), [self.shrink_exp(exp)]))
            case Expr(exp):
                return Expr(self.shrink_exp(exp))
            case Assign([Name() as name], exp):
                return Assign([name], self.shrink_exp(exp))
            case If(exp, body_stmts, orelse_stmts):
                return If(
                    self.shrink_exp(exp),
                    [self.shrink_stmt(stmt) for stmt in body_stmts],
                    [self.shrink_stmt(stmt) for stmt in orelse_stmts],
                )
            case While(test, body, []):
                return While(
                    self.shrink_exp(test), [self.shrink_stmt(stmt) for stmt in body], []
                )
            case Assign([Subscript(lhs, index, Store())], rhs):
                return Assign(
                    [
                        Subscript(
                            self.shrink_exp(lhs),
                            self.shrink_exp(index),
                            Store(),
                        )
                    ],
                    self.shrink_exp(rhs),
                )
            case Return(exp):
                return Return(self.shrink_exp(exp))
            case _:
                return s

    def shrink(self, p: Module):
        match p:
            case Module(list() as body):
                defs = []
                for i in range(len(body)):
                    match body[i]:
                        case FunctionDef(name, args, f_body, _, returns):
                            defs.append(FunctionDef(name, args, [self.shrink_stmt(s) for s in f_body], None, returns, None))
                        case _:
                            main_body = body[i:] + [Return(Constant(0))]
                            main_function = FunctionDef('main', [], [self.shrink_stmt(s) for s in main_body], None, IntType(), None)
                            return Module(defs + [main_function])
                # if program consists only of function defs and main is empty
                main_function = FunctionDef('main', [], [Return(Constant(0))], None, IntType(), None)
                return Module(defs + [main_function])
                
    ############################################################################
    # Reveal functions
    ############################################################################

    def reveal_functions_exp(self, e: expr, functions: dict[str, int]):
        match e:
            case Name(var):
                if var in functions:
                    return FunRef(var, functions[var])
                return e
            case UnaryOp(USub() | Not() as op, exp):
                return UnaryOp(op, self.reveal_functions_exp(exp, functions))
            case BinOp(left, Add() | Sub() | Mult() as op, right):
                return BinOp(self.reveal_functions_exp(left, functions), op, self.reveal_functions_exp(right, functions))
            case BoolOp(And(), [left, right]):
                left = self.reveal_functions_exp(left, functions)
                right = self.reveal_functions_exp(right, functions)
                return IfExp(left, right, Constant(False))
            case BoolOp(Or(), [left, right]):
                left = self.reveal_functions_exp(left, functions)
                right = self.reveal_functions_exp(right, functions)
                return IfExp(left, Constant(True), right)
            case BoolOp(op, [left, right]):
                return BoolOp(op, [self.reveal_functions_exp(left, functions), self.reveal_functions_exp(right, functions)])
            case Compare(left, [cmp], [right]):
                return Compare(self.reveal_functions_exp(left, functions), [cmp], [self.reveal_functions_exp(right, functions)])
            case IfExp(exp, body, orelse):
                return IfExp(
                    self.reveal_functions_exp(exp, functions), self.reveal_functions_exp(body, functions), self.reveal_functions_exp(orelse, functions)
                )
            case Tuple(elts, Load()):
                return Tuple([self.reveal_functions_exp(e, functions) for e in elts], Load())
            case Subscript(lhs, index, Load()):
                return Subscript(self.reveal_functions_exp(lhs, functions), self.reveal_functions_exp(index, functions), Load())
            case List(elts, Load()):
                return List([self.reveal_functions_exp(e, functions) for e in elts], Load())
            case Call(Name("len"), [exp]):
                return Call(Name("len"), [self.reveal_functions_exp(exp, functions)])
            case Call(exp, exps):
                return Call(self.reveal_functions_exp(exp, functions), [self.reveal_functions_exp(e, functions) for e in exps])
            case _:
                return e
    
    def reveal_functions_stmt(self, s: stmt, functions: dict[str, int]):
        match s:
            case Expr(Call(Name("print"), [exp])):
                return Expr(Call(Name("print"), [self.reveal_functions_exp(exp, functions)]))
            case Expr(exp):
                return Expr(self.reveal_functions_exp(exp, functions))
            case Assign([Name() as name], exp):
                return Assign([name], self.reveal_functions_exp(exp, functions))
            case If(exp, body_stmts, orelse_stmts):
                return If(
                    self.reveal_functions_exp(exp, functions),
                    [self.reveal_functions_stmt(stmt, functions) for stmt in body_stmts],
                    [self.reveal_functions_stmt(stmt, functions) for stmt in orelse_stmts],
                )
            case While(test, body, []):
                return While(
                    self.reveal_functions_exp(test, functions), [self.reveal_functions_stmt(stmt, functions) for stmt in body], []
                )
            case Assign([Subscript(lhs, index, Store())], rhs):
                return Assign(
                    [
                        Subscript(
                            self.reveal_functions_exp(lhs, functions),
                            self.reveal_functions_exp(index, functions),
                            Store(),
                        )
                    ],
                    self.reveal_functions_exp(rhs, functions),
                )
            case Return(exp):
                return Return(self.reveal_functions_exp(exp, functions))
            case FunctionDef(name, params, f_body, _, returns):
                return FunctionDef(name, params, [self.reveal_functions_stmt(s, functions) for s in f_body], None, returns)
            case _:
                return s

    def reveal_functions(self, p: Module):
        match p:
            case Module(list() as body):
                functions = {}
                for func in body:
                    match func:
                        case FunctionDef(name, args):
                            functions[name] = len(args)
                return Module([self.reveal_functions_stmt(s, functions) for s in body])

    ############################################################################
    # Resolve
    ############################################################################

    def resolve_exp(self, e: expr):
        match e:
            case UnaryOp(USub() | Not() as op, exp):
                return UnaryOp(op, self.resolve_exp(exp))
            case BinOp(left, Add() | Sub() | Mult() as op, right):
                return BinOp(self.resolve_exp(left), op, self.resolve_exp(right))
            case BoolOp(And(), [left, right]):
                left = self.resolve_exp(left)
                right = self.resolve_exp(right)
                return IfExp(left, right, Constant(False))
            case BoolOp(Or(), [left, right]):
                left = self.resolve_exp(left)
                right = self.resolve_exp(right)
                return IfExp(left, Constant(True), right)
            case BoolOp(op, [left, right]):
                return BoolOp(op, [self.resolve_exp(left), self.resolve_exp(right)])
            case Compare(left, [cmp], [right]):
                return Compare(self.resolve_exp(left), [cmp], [self.resolve_exp(right)])
            case IfExp(exp, body, orelse):
                return IfExp(
                    self.resolve_exp(exp),
                    self.resolve_exp(body),
                    self.resolve_exp(orelse),
                )
            case Tuple(elts, Load()):
                return Tuple([self.resolve_exp(e) for e in elts], Load())
            case Subscript(lhs, index, Load()):
                assert hasattr(
                    lhs, "has_type"
                ), "typechek required to obtain has_type field"
                match lhs.has_type:
                    case ListType(el_ty):
                        return Call(
                            Name("array_load"),
                            [self.resolve_exp(lhs), self.resolve_exp(index)],
                        )
                    case _:
                        return Subscript(
                            self.resolve_exp(lhs), self.resolve_exp(index), Load()
                        )
            case List(elts, Load()):
                return List([self.resolve_exp(e) for e in elts], Load())
            case Call(Name("len"), [exp]):
                assert hasattr(
                    exp, "has_type"
                ), "typechek required to obtain has_type field"
                match exp.has_type:
                    case ListType(el_ty):
                        return Call(Name("array_len"), [self.resolve_exp(exp)])
                    case _:
                        return Call(Name("len"), [self.resolve_exp(exp)])
            case Call(exp, exps):
                return Call(self.resolve_exp(exp), [self.resolve_exp(e) for e in exps])
            case _:
                return e

    def resolve_stmt(self, s: stmt):
        match s:
            case Expr(Call(Name("print"), [exp])):
                return Expr(Call(Name("print"), [self.resolve_exp(exp)]))
            case Expr(exp):
                return Expr(self.resolve_exp(exp))
            case Assign([Name() as name], exp):
                return Assign([name], self.resolve_exp(exp))
            case If(exp, body_stmts, orelse_stmts):
                return If(
                    self.resolve_exp(exp),
                    [self.resolve_stmt(stmt) for stmt in body_stmts],
                    [self.resolve_stmt(stmt) for stmt in orelse_stmts],
                )
            case While(test, body, []):
                return While(
                    self.resolve_exp(test),
                    [self.resolve_stmt(stmt) for stmt in body],
                    [],
                )
            case Assign([Subscript(lhs, index, Store())], rhs):
                assert hasattr(
                    lhs, "has_type"
                ), "typechek required to obtain has_type field"

                match lhs.has_type:
                    case ListType(el_ty):
                        return Expr(
                            Call(
                                Name("array_store"),
                                [
                                    self.resolve_exp(lhs),
                                    self.resolve_exp(index),
                                    self.resolve_exp(rhs),
                                ],
                            )
                        )
                    case _:
                        return Assign(
                            [
                                Subscript(
                                    self.resolve_exp(lhs),
                                    self.resolve_exp(index),
                                    Store(),
                                )
                            ],
                            self.resolve_exp(rhs),
                        )
            case Return(exp):
                return Return(self.resolve_exp(exp))
            case FunctionDef(name, args, f_body, _, returns):
                return FunctionDef(name, args, [self.resolve_stmt(s) for s in f_body], None, returns)
            case _:
                return s

    def resolve(self, p: Module):
        match p:
            case Module(list() as body):
                return Module([self.resolve_stmt(stmt) for stmt in body])

    ############################################################################
    # Check bounds
    ############################################################################

    def check_bounds_exp(self, e: expr):
        match e:
            case UnaryOp(USub() | Not() as op, exp):
                return UnaryOp(op, self.check_bounds_exp(exp))
            case BinOp(left, Add() | Sub() | Mult() as op, right):
                return BinOp(
                    self.check_bounds_exp(left), op, self.check_bounds_exp(right)
                )
            case BoolOp(And(), [left, right]):
                left = self.check_bounds_exp(left)
                right = self.check_bounds_exp(right)
                return IfExp(left, right, Constant(False))
            case BoolOp(Or(), [left, right]):
                left = self.check_bounds_exp(left)
                right = self.check_bounds_exp(right)
                return IfExp(left, Constant(True), right)
            case BoolOp(op, [left, right]):
                return BoolOp(
                    op, [self.check_bounds_exp(left), self.check_bounds_exp(right)]
                )
            case Compare(left, [cmp], [right]):
                return Compare(
                    self.check_bounds_exp(left), [cmp], [self.check_bounds_exp(right)]
                )
            case IfExp(exp, body, orelse):
                return IfExp(
                    self.check_bounds_exp(exp),
                    self.check_bounds_exp(body),
                    self.check_bounds_exp(orelse),
                )
            case Tuple(elts, Load()):
                return Tuple([self.check_bounds_exp(e) for e in elts], Load())
            case Subscript(lhs, Constant(int()) as index, Load()):
                #  tuple, index checked in typecheck pass
                lhs = self.check_bounds_exp(lhs)
                return Subscript(lhs, index, Load())
            case Call(Name("array_load"), [lhs, index]):
                #  array, runtime index check
                lhs = self.check_bounds_exp(lhs)
                index = self.check_bounds_exp(index)
                return IfExp(
                    IfExp(
                        Compare(index, [GtE()], [Constant(0)]),
                        Compare(index, [Lt()], [Call(Name("array_len"), [lhs])]),
                        Constant(False),
                    ),
                    Call(Name("array_load"), [lhs, index]),
                    Call(Name("exit"), []),
                )
            case List(elts, Load()):
                return List([self.check_bounds_exp(e) for e in elts], Load())
            case Call(Name("len"), [exp]):
                #  tuple
                return Call(Name("len"), [self.check_bounds_exp(exp)])
            case Call(Name("array_len"), [arr]):
                #  array
                return Call(Name("array_len"), [self.check_bounds_exp(arr)])
            case Call(exp, exps):
                return Call(self.check_bounds_exp(exp), [self.check_bounds_exp(e) for e in exps])
            case _:
                return e

    def check_bounds_stmt(self, s: stmt):
        match s:
            case Expr(Call(Name("print"), [exp])):
                return Expr(Call(Name("print"), [self.check_bounds_exp(exp)]))
            case Assign([Name() as name], exp):
                return Assign([name], self.check_bounds_exp(exp))
            case If(exp, body_stmts, orelse_stmts):
                return If(
                    self.check_bounds_exp(exp),
                    [self.check_bounds_stmt(stmt) for stmt in body_stmts],
                    [self.check_bounds_stmt(stmt) for stmt in orelse_stmts],
                )
            case While(test, body, []):
                return While(
                    self.check_bounds_exp(test),
                    [self.check_bounds_stmt(stmt) for stmt in body],
                    [],
                )
            case Assign([Subscript(lhs, Constant(int()) as index, Store())], rhs):
                #  tuple, index checked in typecheck pass
                lhs = self.check_bounds_exp(lhs)
                rhs = self.check_bounds_exp(rhs)
                return Assign([Subscript(lhs, index, Store())], rhs)
            case Expr(Call(Name("array_store"), [lhs, index, rhs])):
                #  array, runtime index check
                lhs = self.check_bounds_exp(lhs)
                index = self.check_bounds_exp(index)
                rhs = self.check_bounds_exp(rhs)
                return If(
                    IfExp(
                        Compare(index, [GtE()], [Constant(0)]),
                        Compare(index, [Lt()], [Call(Name("array_len"), [lhs])]),
                        Constant(False),
                    ),
                    [Expr(Call(Name("array_store"), [lhs, index, rhs]))],
                    [Expr(Call(Name("exit"), []))],
                )
            case Expr(exp):
                return Expr(self.check_bounds_exp(exp))
            case Return(exp):
                return Return(self.check_bounds_exp(exp))
            case FunctionDef(name, args, f_body, _, returns):
                return FunctionDef(name, args, [self.check_bounds_stmt(s) for s in f_body], None, returns)
            case _:
                return s

    def check_bounds(self, p: Module):
        match p:
            case Module(list() as body):
                return Module([self.check_bounds_stmt(stmt) for stmt in body])

    ############################################################################
    # Limit functions
    ############################################################################

    def limit_functions_exp(self, e: expr, mapping: dict[str, expr]):
        match e:
            case Name(var) if var in mapping:
                return mapping[var]
            case UnaryOp(USub() | Not() as op, exp):
                return UnaryOp(op, self.limit_functions_exp(exp, mapping))
            case BinOp(left, Add() | Sub() | Mult() as op, right):
                return BinOp(
                    self.limit_functions_exp(left, mapping), op, self.limit_functions_exp(right, mapping)
                )
            case BoolOp(And(), [left, right]):
                left = self.limit_functions_exp(left, mapping)
                right = self.limit_functions_exp(right, mapping)
                return IfExp(left, right, Constant(False))
            case BoolOp(Or(), [left, right]):
                left = self.limit_functions_exp(left, mapping)
                right = self.limit_functions_exp(right, mapping)
                return IfExp(left, Constant(True), right)
            case BoolOp(op, [left, right]):
                return BoolOp(
                    op, [self.limit_functions_exp(left, mapping), self.limit_functions_exp(right, mapping)]
                )
            case Compare(left, [cmp], [right]):
                return Compare(
                    self.limit_functions_exp(left, mapping), [cmp], [self.limit_functions_exp(right, mapping)]
                )
            case IfExp(exp, body, orelse):
                return IfExp(
                    self.limit_functions_exp(exp, mapping),
                    self.limit_functions_exp(body, mapping),
                    self.limit_functions_exp(orelse, mapping),
                )
            case Tuple(elts, Load()):
                return Tuple([self.limit_functions_exp(e, mapping) for e in elts], Load())
            case Subscript(lhs, Constant(int()) as index, Load()):
                return Subscript(self.limit_functions_exp(lhs, mapping), index, Load())
            case List(elts, Load()):
                return List([self.limit_functions_exp(e, mapping) for e in elts], Load())
            case Call(exp, exps):
                if len(exps) > 55:
                    raise Exception(f"Too much arguments in call {exp}, max = 55, current = {len(exps)}")
                if len(exps) > 6:
                    tup = Tuple(exps[5:], Load())
                    return Call(
                        self.limit_functions_exp(exp, mapping),
                        [self.limit_functions_exp(e, mapping) for e in exps[:5]] + [tup])
                return Call(self.limit_functions_exp(exp, mapping),
                            [self.limit_functions_exp(e, mapping) for e in exps])
            case _:
                return e

    def limit_functions_stmt(self, s: stmt, mapping: dict[str, expr]):
        match s:
            case Expr(Call(Name("print"), [exp])):
                return Expr(Call(Name("print"), [self.limit_functions_exp(exp, mapping)]))
            case Assign([Name() as name], exp):
                return Assign([name], self.limit_functions_exp(exp, mapping))
            case If(exp, body_stmts, orelse_stmts):
                return If(
                    self.limit_functions_exp(exp, mapping),
                    [self.limit_functions_stmt(stmt, mapping) for stmt in body_stmts],
                    [self.limit_functions_stmt(stmt, mapping) for stmt in orelse_stmts],
                )
            case While(test, body, []):
                return While(
                    self.limit_functions_exp(test, mapping),
                    [self.limit_functions_stmt(stmt, mapping) for stmt in body],
                    [],
                )
            case Assign([Subscript(lhs, Constant(int()) as index, Store())], rhs):
                return Assign([
                    Subscript(self.limit_functions_exp(lhs, mapping), index, Store())],
                    self.limit_functions_exp(rhs, mapping))
            case Expr(Call(Name("array_store"), [lhs, index, rhs])):
                return Expr(Call(Name("array_store"), [
                    self.limit_functions_exp(lhs, mapping),
                    self.limit_functions_exp(index, mapping),
                    self.limit_functions_exp(rhs, mapping)
                ]))
            case Expr(exp):
                return Expr(self.limit_functions_exp(exp, mapping))
            case Return(exp):
                return Return(self.limit_functions_exp(exp, mapping))
            case FunctionDef(name, params, f_body, _, returns):
                if len(params) > 55:
                    raise Exception(f"Too much params in function {name}, max = 55, current = {len(params)}")
                if len(params) > 6:
                    tuple_var = generate_name("params_tuple")
                    tuple_tys = [ty for _, ty in params[5:]]
                    tuple_ty = TupleType(tuple_tys)
                    new_params = params[:5] + [(tuple_var, tuple_ty)]
                    names_mapping = {x: Subscript(Name(tuple_var), Constant(i), Load()) for i, (x, _) in enumerate(params[5:])}
                    new_mapping = mapping.copy()
                    new_mapping.update(names_mapping)
                    return FunctionDef(name, new_params, [self.limit_functions_stmt(s, new_mapping) for s in f_body], None, returns)    

                return FunctionDef(name, params, [self.limit_functions_stmt(s, mapping) for s in f_body], None, returns)
            case _:
                return s

    def limit_functions(self, p: Module):
        match p:
            case Module(list() as body):
                mapping = {}
                return Module([self.limit_functions_stmt(s, mapping) for s in body])

    ############################################################################
    # Expose allocation
    ############################################################################

    def expose_allocation_exp(self, e: expr) -> expr:
        match e:
            case Tuple(expressions, Load()):
                assignments = []
                tuple_assignments = []
                tuple_var = Name(generate_name("alloc"))

                for i, init_expr in enumerate(expressions):
                    init_expr = self.expose_allocation_exp(init_expr)
                    new_var = Name(generate_name("init"))
                    assignments += [Assign([new_var], init_expr)]
                    tuple_assignments += [
                        Assign([Subscript(tuple_var, Constant(i), Store())], new_var)
                    ]

                assert hasattr(
                    e, "has_type"
                ), "required field has_type for Tuple, you might forgot the required type_check before this pass"

                t_type = e.has_type
                assert isinstance(
                    t_type, TupleType
                ), f"Type error in list creation {t_type} != TupleType"

                length = len(expressions)
                bytes_required = length * 8 + 8

                return Begin(
                    [
                        *assignments,
                        If(
                            Compare(
                                BinOp(
                                    GlobalValue("free_ptr"),
                                    Add(),
                                    Constant(bytes_required),
                                ),
                                [Lt()],
                                [GlobalValue("fromspace_end")],
                            ),
                            [],
                            [Collect(bytes_required)],
                        ),
                        Assign([tuple_var], Allocate(length, t_type)),
                        *tuple_assignments,
                    ],
                    tuple_var,
                )

            case List(elts, Load()):
                assignments = []
                array_assignments = []
                array_var = Name(generate_name("alloc"))

                for i, init_expr in enumerate(elts):
                    init_expr = self.expose_allocation_exp(init_expr)
                    new_var = Name(generate_name("init"))
                    assignments += [Assign([new_var], init_expr)]
                    array_assignments += [
                        Assign([Subscript(array_var, Constant(i), Store())], new_var)
                    ]

                assert hasattr(
                    e, "has_type"
                ), "required field has_type for Tuple, you might forgot the required type_check before this pass"

                t_type = e.has_type
                assert isinstance(
                    t_type, ListType
                ), f"Type error in list creation {t_type} != ListType"

                length = len(elts)
                bytes_required = length * 8 + 8

                return Begin(
                    [
                        *assignments,
                        If(
                            Compare(
                                BinOp(
                                    GlobalValue("free_ptr"),
                                    Add(),
                                    Constant(bytes_required),
                                ),
                                [Lt()],
                                [GlobalValue("fromspace_end")],
                            ),
                            [],
                            [Collect(bytes_required)],
                        ),
                        Assign([array_var], AllocateArray(length, t_type)),
                        *array_assignments,
                    ],
                    array_var,
                )
            case UnaryOp((USub() | Not()) as op, exp):
                return UnaryOp(op, self.expose_allocation_exp(exp))
            case BinOp(left, (Add() | Sub() | Mult()) as op, right):
                return BinOp(
                    self.expose_allocation_exp(left),
                    op,
                    self.expose_allocation_exp(right),
                )
            case BoolOp(boolop, [left, right]):
                return BoolOp(
                    boolop,
                    [
                        self.expose_allocation_exp(left),
                        self.expose_allocation_exp(right),
                    ],
                )
            case Compare(left, [cmp], [right]):
                return Compare(
                    self.expose_allocation_exp(left),
                    [cmp],
                    [self.expose_allocation_exp(right)],
                )
            case IfExp(test, body, orelse):
                return IfExp(
                    self.expose_allocation_exp(test),
                    self.expose_allocation_exp(body),
                    self.expose_allocation_exp(orelse),
                )
            case Subscript(exp, Constant(int() as idx), Load()):
                return Subscript(self.expose_allocation_exp(exp), Constant(idx), Load())
            case Call(Name("array_load"), [lhs, index]):
                return Call(
                    Name("array_load"),
                    [
                        self.expose_allocation_exp(lhs),
                        self.expose_allocation_exp(index),
                    ],
                )
            case Call(Name("len"), [exp]):
                return Call(Name("len"), [self.expose_allocation_exp(exp)])
            case Call(Name("array_len"), [exp]):
                return Call(Name("array_len"), [self.expose_allocation_exp(exp)])
            case Call(exp, exps):
                return Call(self.expose_allocation_exp(exp), [self.expose_allocation_exp(e) for e in exps])
            case _:
                return e

    def expose_allocation_stmt(self, s: stmt) -> stmt:
        match s:
            case Expr(Call(Name("print"), [exp])):
                return Expr(Call(Name("print"), [self.expose_allocation_exp(exp)]))
            case Expr(Call(Name("array_store"), [lhs, index, rhs])):
                return Expr(
                    Call(
                        Name("array_store"),
                        [
                            self.expose_allocation_exp(lhs),
                            self.expose_allocation_exp(index),
                            self.expose_allocation_exp(rhs),
                        ],
                    )
                )
            case Assign([Name(var)], exp):
                return Assign([Name(var)], self.expose_allocation_exp(exp))
            case Assign([Subscript(lhs, Constant(int()) as index, Store())], rhs):
                return Assign(
                    [Subscript(self.expose_allocation_exp(lhs), index, Store())],
                    self.expose_allocation_exp(rhs),
                )
            case If(test, list() as body, list() as orelse):
                return If(
                    self.expose_allocation_exp(test),
                    [self.expose_allocation_stmt(stmt) for stmt in body],
                    [self.expose_allocation_stmt(stmt) for stmt in orelse],
                )
            case While(test, list() as body, []):
                return While(
                    self.expose_allocation_exp(test),
                    [self.expose_allocation_stmt(stmt) for stmt in body],
                    [],
                )
            case Expr(exp):
                return Expr(self.expose_allocation_exp(exp))
            case Return(exp):
                return Return(self.expose_allocation_exp(exp))
            case FunctionDef(name, args, f_body, _, returns):
                return FunctionDef(name, args, [self.expose_allocation_stmt(s) for s in f_body], None, returns)
            case _ as unreacheble:
                raise Exception(f"Unexpected, {unreacheble}")

    def expose_allocation(self, p: Module) -> Module:
        match p:
            case Module(list() as body):
                return Module([self.expose_allocation_stmt(s) for s in body])

    ############################################################################
    # Remove Complex Operands
    ############################################################################

    def rco_exp(self, e: expr, need_atomic: bool) -> tuple[expr, Temporaries]:
        match e:
            case Constant() | Name() | GlobalValue() | Call(Name("exit"), []):
                return (e, [])
            
            case FunRef():
                if need_atomic:
                    new_var = Name(generate_name("fun"))
                    return (new_var, [(new_var, e)])
                return (e, [])

            case AllocateArray():
                if need_atomic:
                    new_var = Name(generate_name("tmp"))
                    return (new_var, [(new_var, e)])
                return (e, [])

            case Allocate():
                if need_atomic:
                    new_var = Name(generate_name("tmp"))
                    return (new_var, [(new_var, e)])
                return (e, [])

            case UnaryOp((USub() | Not()) as op, expr):
                atm, temporaries = self.rco_exp(expr, True)
                new_expr = UnaryOp(op, atm)
                if need_atomic:
                    new_var = Name(generate_name("tmp"))
                    return (new_var, [*temporaries, (new_var, new_expr)])
                return (new_expr, temporaries)

            case BinOp(left, (Add() | Sub() | Mult()) as op, right):
                left_atm, left_temporaries = self.rco_exp(left, True)
                right_atm, right_temporaries = self.rco_exp(right, True)
                new_expr = BinOp(left_atm, op, right_atm)
                if need_atomic:
                    new_var = Name(generate_name("tmp"))
                    return (
                        new_var,
                        [*left_temporaries, *right_temporaries, (new_var, new_expr)],
                    )
                return (new_expr, [*left_temporaries, *right_temporaries])

            case Compare(left, [cmp], [right]):
                left_atm, left_temporaries = self.rco_exp(left, True)
                right_atm, right_temporaries = self.rco_exp(right, True)
                new_expr = Compare(left_atm, [cmp], [right_atm])
                if need_atomic:
                    new_var = Name(generate_name("tmp"))
                    return (
                        new_var,
                        [*left_temporaries, *right_temporaries, (new_var, new_expr)],
                    )
                return (new_expr, [*left_temporaries, *right_temporaries])

            case Call(Name("input_int"), []):
                if need_atomic:
                    new_var = Name(generate_name("tmp"))
                    return (new_var, [(new_var, e)])
                return (e, [])

            case IfExp(test, body, orelse):
                test, test_temporaries = self.rco_exp(test, False)
                body, body_temporaries = self.rco_exp(body, False)
                orelse, orelse_temporaries = self.rco_exp(orelse, False)

                body_assigns = [Assign([name], exp) for name, exp in body_temporaries]
                orelse_assigns = [
                    Assign([name], exp) for name, exp in orelse_temporaries
                ]
                new_body_expr = Begin(body_assigns, body)
                new_orelse_expr = Begin(orelse_assigns, orelse)
                new_expr = IfExp(test, new_body_expr, new_orelse_expr)

                if need_atomic:
                    new_var = Name(generate_name("tmp"))
                    return (new_var, [*test_temporaries, (new_var, new_expr)])
                return (new_expr, test_temporaries)

            case Begin(list() as body, result):
                body = sum([self.rco_stmt(stmt) for stmt in body], [])
                result, temporaries = self.rco_exp(result, False)
                new_expr = Begin(body, result)
                if need_atomic:
                    new_var = Name(generate_name("tmp"))
                    return (new_var, [*temporaries, (new_var, new_expr)])
                return (new_expr, temporaries)

            case Subscript(left, right, Load()):
                left, left_temporaries = self.rco_exp(left, True)
                right, right_temporaries = self.rco_exp(right, True)
                new_expr = Subscript(left, right, Load())
                if need_atomic:
                    new_var = Name(generate_name("tmp"))
                    return (
                        new_var,
                        [*left_temporaries, *right_temporaries, (new_var, new_expr)],
                    )
                return (new_expr, [*left_temporaries, *right_temporaries])

            case Call(Name("len"), [exp]):
                exp, temporaries = self.rco_exp(exp, True)
                new_expr = Call(Name("len"), [exp])
                if need_atomic:
                    new_var = Name(generate_name("tmp"))
                    return (new_var, [*temporaries, (new_var, new_expr)])
                return (new_expr, temporaries)

            case Call(Name("array_len"), [exp]):
                exp, temporaries = self.rco_exp(exp, True)
                new_expr = Call(Name("array_len"), [exp])
                if need_atomic:
                    new_var = Name(generate_name("tmp"))
                    return (new_var, [*temporaries, (new_var, new_expr)])
                return (new_expr, temporaries)

            case Call(Name("array_load"), [lhs, index]):
                lhs, lhs_temporaries = self.rco_exp(lhs, True)
                index, index_temporaries = self.rco_exp(index, True)
                new_expr = Call(Name("array_load"), [lhs, index])
                if need_atomic:
                    new_var = Name(generate_name("tmp"))
                    return (
                        new_var,
                        [*lhs_temporaries, *index_temporaries, (new_var, new_expr)],
                    )
                return (new_expr, [*lhs_temporaries, *index_temporaries])
            case Call(lhs, exps):
                lhs, lhs_temporaries = self.rco_exp(lhs, True)
                new_exps = []
                exps_temporaries = []
                for e in exps:
                    new_exp, exp_temporaries = self.rco_exp(e, True)
                    new_exps.append(new_exp)
                    exps_temporaries += exp_temporaries
                new_expr = Call(lhs, new_exps)
                if need_atomic:
                    new_var = Name(generate_name("tmp"))
                    return (
                        new_var, lhs_temporaries + exps_temporaries + [(new_var, new_expr)]
                    )
                return (new_expr, lhs_temporaries + exps_temporaries)
            case _:
                raise Exception(type(e))

    def rco_stmt(self, s: stmt) -> list[stmt]:
        match s:
            case Expr(Call(Name("print"), [expr])):
                atm, temporaries = self.rco_exp(expr, True)
                assigns = [Assign([name], exp) for name, exp in temporaries]
                new_expr = Expr(Call(Name("print"), [atm]))
                return [*assigns, new_expr]

            case Expr(Call(Name("array_store"), [lhs, index, rhs])):
                lhs, lhs_temporaries = self.rco_exp(lhs, True)
                index, index_temporaries = self.rco_exp(index, True)
                rhs, rhs_temporaries = self.rco_exp(rhs, True)
                temporaries = lhs_temporaries + index_temporaries + rhs_temporaries
                assigns = [Assign([name], exp) for name, exp in temporaries]
                new_expr = Expr(Call(Name("array_store"), [lhs, index, rhs]))
                return [*assigns, new_expr]

            case Assign([Subscript(left, Constant(int()) as index, Store())], right):
                left, left_temporaries = self.rco_exp(left, True)
                index, index_temporaries = self.rco_exp(index, True)
                right, right_temporaries = self.rco_exp(right, True)
                temporaries = left_temporaries + index_temporaries + right_temporaries
                assigns = [Assign([name], exp) for name, exp in temporaries]
                new_expr = Assign([Subscript(left, index, Store())], right)
                return [*assigns, new_expr]

            case Assign([Name(var)], expr):
                expr, temporaries = self.rco_exp(expr, False)
                assigns = [Assign([name], exp) for name, exp in temporaries]
                new_expr = Assign([Name(var)], expr)
                return [*assigns, new_expr]

            case If(test, list() as body, list() as orelse):
                expr, temporaries = self.rco_exp(test, False)
                assigns = [Assign([name], exp) for name, exp in temporaries]

                new_body = []
                for stmt in body:
                    new_body = [*new_body, *self.rco_stmt(stmt)]
                new_orelse = []
                for stmt in orelse:
                    new_orelse = [*new_orelse, *self.rco_stmt(stmt)]
                new_expr = If(expr, new_body, new_orelse)
                return [*assigns, new_expr]

            case While(test, body, []):
                expr, temporaries = self.rco_exp(test, False)
                assigns = [Assign([name], exp) for name, exp in temporaries]
                new_test = Begin(assigns, expr)

                new_body = []
                for stmt in body:
                    new_body = [*new_body, *self.rco_stmt(stmt)]
                return [While(new_test, new_body, [])]

            case Collect():
                return [s]

            case Expr(value):
                expr, temporaries = self.rco_exp(value, False)
                assigns = [Assign([name], exp) for name, exp in temporaries]
                new_expr = Expr(expr)
                return [*assigns, new_expr]

            case Return(exp):
                expr, temporaries = self.rco_exp(exp, False)
                assigns = [Assign([name], exp) for name, exp in temporaries]
                new_expr = Return(expr)
                return [*assigns, new_expr]

            case FunctionDef(name, args, f_body, _, returns):
                new_body = []
                for stmt in f_body:
                    new_body += self.rco_stmt(stmt)
                return [FunctionDef(name, args, new_body, None, returns)]
            
            case _:
                raise Exception(type(s))

    def remove_complex_operands(self, p: Module) -> Module:
        match p:
            case Module(body):
                new_body = []
                for stmt in body:
                    stmts = self.rco_stmt(stmt)
                    new_body = [*new_body, *stmts]
                return Module(new_body)

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
            case Begin(body, result):
                new_body = self.explicate_effect(result, cont, basic_blocks)
                for stmt in reversed(body):
                    new_body = self.explicate_stmt(stmt, new_body, basic_blocks)
                return new_body
            case Allocate() | AllocateArray() | Call():
                # also handes Call(Name("input_int"), [])
                return Promise(lambda: [Expr(e)] + force(cont))
            case _:
                return Promise(lambda: force(cont))

    def explicate_assign(
        self,
        rhs: expr,
        lhs: expr,
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
            case Subscript(_, _, Load()) | Call(_, _):
                # also handles Call(Name("array_load"), [lhs, index])
                def inner():
                    new_var = Name(generate_name("tmp"))
                    return force(
                        self.explicate_assign(
                            cnd,
                            new_var,
                            self.explicate_pred(new_var, thn, els, basic_blocks),
                            basic_blocks
                        )
                    )
                return Promise(inner)
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
    
    def explicate_tail(self, e: expr, basic_blocks: dict[str, list[stmt]]) -> LazySS:
        match e:
            case Begin(body, result):
                new_body = self.explicate_tail(result, basic_blocks)
                for stmt in reversed(body):
                    new_body = self.explicate_stmt(stmt, new_body, basic_blocks)
                return new_body
            case IfExp(test, body, orelse):
                def inner():
                    new_var = Name(generate_name("tmp"))
                    return force(self.explicate_assign(e, new_var, [Return(new_var)], basic_blocks))
                return Promise(inner)
                # return self.explicate_pred(test, body, orelse, basic_blocks)
            case Call(callee, args):
                return [TailCall(callee, args)]
            case _:
                return [Return(e)]

    def explicate_stmt(
        self, s: stmt, cont: LazySS, basic_blocks: dict[str, list[stmt]]
    ) -> LazySS:
        match s:
            case Assign([lhs], rhs):
                return self.explicate_assign(rhs, lhs, cont, basic_blocks)
            case Expr(Call(Name("print"), [_])):
                return Promise(lambda: [s] + force(cont))
            case If(test, body, orelse):
                next_block = create_block(cont, basic_blocks)
                new_body = next_block
                for stmt in reversed(body):
                    new_body = self.explicate_stmt(stmt, new_body, basic_blocks)

                new_orelse = next_block
                for stmt in reversed(orelse):
                    new_orelse = self.explicate_stmt(stmt, new_orelse, basic_blocks)

                return self.explicate_pred(test, new_body, new_orelse, basic_blocks)
            case While(test, body, []):

                def inner():
                    label = label_name(generate_name("block"))

                    goto_out_of_cycle = create_block(cont, basic_blocks)
                    new_body = [Goto(label)]
                    for stmt in reversed(body):
                        new_body = self.explicate_stmt(stmt, new_body, basic_blocks)

                    condition = self.explicate_pred(
                        test, new_body, goto_out_of_cycle, basic_blocks
                    )
                    basic_blocks[label] = force(condition)
                    return [Goto(label)]

                return Promise(inner)
            case Collect():
                return Promise(lambda: [s] + force(cont))
            case Expr(Call(Name("array_store"), [lhs, index, rhs])):
                return Promise(lambda: [s] + force(cont))
            case Expr(value):
                return self.explicate_effect(value, cont, basic_blocks)
            case Return(value):
                return self.explicate_tail(value, basic_blocks)
            case _ as unreacheble:
                raise Exception(f"Unexpected {unreacheble}")

    def explicate_function(self, f: FunctionDef) -> FunctionDef:
        match f:
            case FunctionDef(name, params, f_body, _, returns):
                basic_blocks = {}
                new_body = []
                if name == "main":
                    new_body += [Return(Constant(0))]
                for s in reversed(f_body):
                    new_body = force(self.explicate_stmt(s, new_body, basic_blocks))
                basic_blocks[label_block_start(name)] = new_body
                return FunctionDef(name, params, basic_blocks, None, returns, None)

    def explicate_control(self, p):
        match p:
            case Module(body):
                defs = [self.explicate_function(f) for f in reversed(body)]
                return CProgramDefs(defs)

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
            case GlobalValue(var) | FunRef(var):
                return Global(var)

    def select_exp(self, e: expr, target: None | Variable | Reg = None) -> list[instr]:
        if target is None:
            match e:
                case Call(Name("input_int"), []):
                    return [Callq("read_int", 0)]
                case _:
                    return []

        match e:
            case Name() | Constant():
                return [Instr("movq", [self.select_arg(e), target])]
            case FunRef():
                return [Instr("leaq", [self.select_arg(e), target])]
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

            case BinOp(left, (Add() | Sub() | Mult()) as op, right):
                arg0 = self.select_arg(left)
                arg1 = self.select_arg(right)
                instr_name = None
                match op:
                    case Add():
                        instr_name = "addq"
                    case Sub():
                        instr_name = "subq"
                    case Mult():
                        instr_name = "imulq"

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
            case Subscript(left, Constant(int() as idx), Load()):
                # tuple
                arg0 = self.select_arg(left)
                offset = 8 * (idx + 1)
                return [
                    Instr("movq", [arg0, Reg("r11")]),
                    Instr("movq", [Deref("r11", offset), target]),
                ]
            case Call(Name("array_load"), [lhs, index]):
                # array
                arg0 = self.select_arg(lhs)
                arg1 = self.select_arg(index)
                temp_var = Variable(generate_name("tmp"))
                return [
                    Instr("movq", [arg0, Reg("r11")]),
                    Instr("movq", [arg1, temp_var]),
                    Instr("imulq", [Immediate(8), temp_var]),
                    Instr("addq", [temp_var, Reg("r11")]),
                    Instr("movq", [Deref("r11", 8), target]),
                ]

            case Allocate(length, TupleType(types)):
                offset = 8 * (length + 1)

                def calc_tuple_tag():
                    tag = (length << 1) | 1
                    mask = 0
                    for ty in reversed(types):
                        mask <<= 1
                        if is_ptr(ty):
                            mask = 1 | mask
                    return tag | (mask << 7)

                return [
                    Instr("movq", [Global("free_ptr"), Reg("r11")]),
                    Instr("addq", [Immediate(offset), Global("free_ptr")]),
                    Instr("movq", [Immediate(calc_tuple_tag()), Deref("r11", 0)]),
                    Instr("movq", [Reg("r11"), target]),
                ]
            case AllocateArray(length, ListType(el_ty)):
                offset = 8 * (length + 1)

                def calc_array_tag():
                    tag = (length << 2) | 1
                    if is_ptr(el_ty):
                        tag = tag | 2
                    return tag | (1 << 62)

                return [
                    Instr("movq", [Global("free_ptr"), Reg("r11")]),
                    Instr("addq", [Immediate(offset), Global("free_ptr")]),
                    Instr("movq", [Immediate(calc_array_tag()), Deref("r11", 0)]),
                    Instr("movq", [Reg("r11"), target]),
                ]

            case Call(Name("len"), [arg0]):
                arg0 = self.select_arg(arg0)
                length_mask = 2**7 - 2  # 0x01111110
                return [
                    Instr("movq", [arg0, Reg("r11")]),
                    Instr("movq", [Deref("r11", 0), target]),
                    Instr("andq", [Immediate(length_mask), target]),
                    Instr("sarq", [Immediate(1), target]),
                ]
            case Call(Name("array_len"), [arg0]):
                arg0 = self.select_arg(arg0)
                length_mask = 2**62 - 4  # 0x00111...11100
                temp_var = Variable(generate_name("arr_l_mask"))
                return [
                    Instr("movq", [arg0, Reg("r11")]),
                    Instr("movq", [Deref("r11", 0), target]),
                    Instr("movq", [Immediate(length_mask), temp_var]),
                    Instr("andq", [temp_var, target]),
                    Instr("sarq", [Immediate(2), target]),
                ]
            case Call(Name("exit"), []):
                return [
                    Instr("movq", [Immediate(255), Reg("rdi")]),
                    Callq("exit", 1),
                ]
            case Call(callee, args):
                params_move_instructions = [
                    Instr("movq", [self.select_arg(arg), Reg(reg)])
                    for reg, arg in zip(params_regs, args)
                ]
                return params_move_instructions + [
                    IndirectCallq(self.select_arg(callee), len(args)),
                    Instr("movq", [Reg("rax"), target])
                ]
            case _:
                raise Exception(f"not supported expression: {e}")

    def select_stmt(self, s: stmt) -> list[instr]:
        match s:
            case Expr(Call(Name("print"), [atm])):
                arg = self.select_arg(atm)
                return [
                    Instr("movq", [arg, Reg("rdi")]),
                    Callq("print_int", 1),
                ]
            case Assign([Name(var)], exp):
                target = Variable(var)
                return self.select_exp(exp, target)
            case Collect(size):
                return [
                    Instr("movq", [Reg("r15"), Reg("rdi")]),
                    Instr("movq", [Immediate(size), Reg("rsi")]),
                    Callq("collect", 2),
                ]
            case Assign([Subscript(left, Constant(int() as idx), Store())], right):
                left = self.select_arg(left)
                right = self.select_arg(right)
                offset = 8 * (idx + 1)
                return [
                    Instr("movq", [left, Reg("r11")]),
                    Instr("movq", [right, Deref("r11", offset)]),
                ]
            case Expr(Call(Name("array_store"), [lhs, index, rhs])):
                arg0 = self.select_arg(lhs)
                arg1 = self.select_arg(index)
                arg2 = self.select_arg(rhs)
                temp_var = Variable(generate_name("tmp"))
                return [
                    Instr("movq", [arg0, Reg("r11")]),
                    Instr("movq", [arg1, temp_var]),
                    Instr("imulq", [Immediate(8), temp_var]),
                    Instr("addq", [temp_var, Reg("r11")]),
                    Instr("movq", [arg2, Deref("r11", 8)]),
                ]
            case Expr(exp):
                return self.select_exp(exp)
            case _:
                raise Exception("E")

    def select_tail(self, t: stmt, function_name: str) -> list[instr]:
        match t:
            case Return(value):
                return [
                    *self.select_exp(value, Reg("rax")),
                    Jump(label_block_conclusion(function_name)),
                ]
            case Goto(label):
                return [Jump(label)]
            case If(
                Compare(_, [_], [_]),
                [Goto(label_thn)],
                [Goto(label_els)],
            ) if label_thn == label_els:
                return [Jump(label_els)]
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
            case TailCall(callee, args):
                params_move_instructions = [
                    Instr("movq", [self.select_arg(arg), Reg(reg)])
                    for reg, arg in zip(params_regs, args)
                ]
                return params_move_instructions + [
                    TailJump(self.select_arg(callee), len(args))
                ]
            case _:
                raise Exception("E")
    
    def select_function(self, f: FunctionDef) -> FunctionDef:
        match f:
            case FunctionDef(name, params, f_blocks, _, returns):
                assert (
                    hasattr(f, "var_types")
                ), "Type check CTup required to obrain required var_types field"
                names = [var for var, _ in params]
                params_move_instructions = [
                    Instr("movq", [Reg(reg), Variable(var)])
                    for reg, var in zip(params_regs, names)
                ]
                
                new_f_blocks = {label_block_conclusion(name): []}

                for label, (*ss, tail) in f_blocks.items():
                    block = []
                    for stmt in ss:
                        block += self.select_stmt(stmt)
                    block += self.select_tail(tail, name)
                    new_f_blocks[label] = block

                new_f_blocks[label_block_start(name)] = params_move_instructions + new_f_blocks[label_block_start(name)]
                new_def = FunctionDef(name, [], new_f_blocks, None, returns)
                new_def.var_types = f.var_types
                return new_def

    def select_instructions(self, p: CProgram) -> X86ProgramDefs:
        match p:
            case CProgramDefs(defs):
                new_defs = [self.select_function(f) for f in defs]
                return X86ProgramDefs(new_defs)

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

    def build_cfg(self, basic_blocks: dict[str, list[instr]]) -> DirectedAdjList:
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
                return get_used_params_regs(num_args)
            case IndirectCallq(callee_addr, num_args) | TailJump(callee_addr, num_args):
                read_regs = get_used_params_regs(num_args)
                read_regs.add(callee_addr)
                return read_regs
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
            case Callq() | IndirectCallq():
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
        l_after: set[location],
    ) -> set[location]:
        # l_after должен быть объединением всех l_before для блоков, в которые есть переход
        # т.е. в данной функции, при обработке jump инструкций, никакие доп сведения не берутся
        l_before = l_after
        for instr in reversed(block):
            mapping[instr] = l_after

            read = self.compute_R(instr)
            write = self.compute_W(instr)
            l_before = l_after.difference(write).union(read)

            l_after = l_before
        return l_before

    def uncover_live(self, f: FunctionDef) -> Dict[instr, Set[location]]:
        match f:
            case FunctionDef(_, _, basic_blocks):
                cfg = self.build_cfg(basic_blocks)
                transposed_cfg = transpose(cfg)
                mapping = {}

                def transfer_live(
                    label: str, live_after: set[location]
                ) -> set[location]:
                    l_before = self.uncover_live_block(
                        basic_blocks[label], mapping, live_after
                    )
                    return l_before

                analyze_dataflow(transposed_cfg, transfer_live, set(), set.union)
                return mapping

    ############################################################################
    # Remove Jumps
    ############################################################################

    def remove_jumps(self, p: X86ProgramDefs) -> X86ProgramDefs:
        match p:
            case X86ProgramDefs(defs):
                new_defs = []
                for function in defs:
                    match function:
                        case FunctionDef(name, [], basic_blocks, _, returns, _):
                            assert (
                                hasattr(function, "var_types")
                            ), "Type check required to obrain required var_types field"
                            cfg = self.build_cfg(basic_blocks)
                            transposed_cfg = transpose(cfg)
                            ordering: list[str] = topological_stable_sort(transposed_cfg)

                            new_basic_blocks = {}
                            for label in ordering:
                                block = basic_blocks[label]
                                if label == label_block_conclusion(name):
                                    new_basic_blocks[label_block_conclusion(name)] = block
                                else:
                                    (*prevs, last) = block
                                    only_one_pred = lambda label: len(set(cfg.ins[label])) == 1

                                    match last:
                                        case Jump(succ_block) if (
                                            succ_block != label_block_conclusion(name)
                                            and only_one_pred(succ_block)
                                        ):
                                            block_to_merge = new_basic_blocks[succ_block]
                                            new_block = prevs + block_to_merge
                                            new_basic_blocks[label] = new_block
                                            new_basic_blocks.pop(succ_block)

                                            # handling cfg
                                            for succ in cfg.out[succ_block]:
                                                cfg.add_edge(label, succ)
                                            cfg.remove_vertex(succ_block)
                                        case _:
                                            new_basic_blocks[label] = block
                            new_def = FunctionDef(name, [], new_basic_blocks, None, returns, None)
                            new_def.var_types = function.var_types
                            new_defs.append(new_def)
                return X86ProgramDefs(new_defs)

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

    def collect_vars(self, basic_blocks: dict[str, list[instr]]) -> list[Variable]:
        variables = set()
        for block in basic_blocks.values():
            for instr in block:
                variables = variables.union(self.collect_vars_instr(instr))
        return variables

    ############################################################################
    # Building interference graph
    ############################################################################

    def build_interference(self, f: FunctionDef) -> UndirectedAdjList:
        match f:
            case FunctionDef(name, _, basic_blocks, _, returns):
                assert (
                    hasattr(f, "var_types")
                ), "Type check CTup required to obrain required var_types field"
                var_types = f.var_types
                liveness = self.uncover_live(f)
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
                            case Callq("collect") | IndirectCallq() | TailJump():
                                for v in filter(
                                    lambda x: (isinstance(x, Variable)), live_after
                                ):
                                    if isinstance(
                                        var_types[v.id], TupleType
                                    ) or isinstance(var_types[v.id], ListType):
                                        for reg in [
                                            Reg("rsp"),
                                            Reg("rbp"),
                                            Reg("rbx"),
                                            Reg("r12"),
                                            Reg("r13"),
                                            Reg("r14"),
                                            Reg("r15"),
                                        ]:
                                            graph.add_edge(v, reg)

                                write_to = self.compute_W(instr)
                                for d in write_to:
                                    for v in live_after:
                                        if v != d:
                                            graph.add_edge(d, v)
                            case _:
                                write_to = self.compute_W(instr)
                                for d in write_to:
                                    for v in live_after:
                                        if v != d:
                                            graph.add_edge(d, v)
                return graph

    def build_move_graph(self, f: FunctionDef) -> UndirectedAdjList:
        match f:
            case FunctionDef(_, _, basic_blocks):
                graph = UndirectedAdjList()
                for block in basic_blocks.values():
                    for instr in block:
                        match instr:
                            case Instr("movq", [Variable() | Reg() as s, Variable() as d]):
                                graph.add_edge(s, d)
                            case Instr("movq", [Variable() as s, Reg() as d]):
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

        def lowest_available_color(alredy_used_colors: list[int]):
            color = 0
            while color in alredy_used_colors:
                color += 1
            return color

        def available_move_related_color(x) -> int | None:
            not_available = saturations[x]
            related = move_graph.adjacent(x)
            move_related_colors = []
            for var in related:
                match var:
                    case Variable():
                        if var in color_mapping:
                            move_related_colors.append(color_mapping[var])
                    case Reg(reg):
                        if register_to_integer[reg] >= 0:
                            move_related_colors.append(register_to_integer[reg])

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

    def assign_homes_arg(
        self,
        a: arg,
        home: Dict[Variable, int],
        var_types: dict[str, Type],
        spilled_to_root: dict[int, int],
        spilled_to_procedure_stack: dict[int, int],
    ) -> arg:
        match a:
            case Variable(var):
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
                    # stack
                    if isinstance(var_types[var], TupleType) or isinstance(
                        var_types[var], ListType
                    ):
                        # spill to root stack
                        if mapped in spilled_to_root:
                            return Deref("r15", spilled_to_root[mapped])
                        spilled_to_root[mapped] = -8 * (len(spilled_to_root) + 1)
                        return Deref("r15", spilled_to_root[mapped])

                    if mapped in spilled_to_procedure_stack:
                        return Deref("rbp", spilled_to_procedure_stack[mapped])
                    else:
                        spilled_to_procedure_stack[mapped] = -8 * (
                            len(spilled_to_procedure_stack) + 1
                        )
                        return Deref("rbp", spilled_to_procedure_stack[mapped])
            case _:
                return a

    def assign_homes_instr(
        self,
        i: instr,
        home: Dict[Variable, int],
        var_types: dict[str, Type],
        spilled_to_root: dict[int, int],
        spilled_to_procedure_stack: dict[int, int],
    ) -> instr:
        match i:
            case IndirectCallq(arg0, num_args):
                arg0 = self.assign_homes_arg(arg0, home, var_types, spilled_to_root, spilled_to_procedure_stack)
                return IndirectCallq(arg0, num_args)
            case TailJump(arg0, arity):
                arg0 = self.assign_homes_arg(arg0, home, var_types, spilled_to_root, spilled_to_procedure_stack)
                return TailJump(arg0, arity)
            case Instr(cmd, [arg0, arg1]):
                arg0 = self.assign_homes_arg(
                    arg0, home, var_types, spilled_to_root, spilled_to_procedure_stack
                )
                arg1 = self.assign_homes_arg(
                    arg1, home, var_types, spilled_to_root, spilled_to_procedure_stack
                )
                return Instr(cmd, [arg0, arg1])
            case Instr(cmd, [arg0]):
                arg0 = self.assign_homes_arg(
                    arg0, home, var_types, spilled_to_root, spilled_to_procedure_stack
                )
                return Instr(cmd, [arg0])
            case _:
                return i
    
    def assign_homes_function(self, f: FunctionDef) -> FunctionDef:
        match f:
            case FunctionDef(name, [], basic_blocks, _, returns):
                assert (
                    hasattr(f, "var_types")
                ), "Type check CTup required to obrain required var_types field"
                var_types = f.var_types
                interference_graph = self.build_interference(f)
                variables = self.collect_vars(basic_blocks)
                move_graph = self.build_move_graph(f)
                home = self.color_graph(
                    interference_graph, variables, move_graph
                )
                new_blocks = {}
                spilled_to_root = {}
                spilled_to_procedure_stack = {}

                for label, block in basic_blocks.items():
                    new_block_body = [
                        self.assign_homes_instr(
                            instr,
                            home,
                            var_types,
                            spilled_to_root,
                            spilled_to_procedure_stack,
                        )
                        for instr in block
                    ]
                    new_blocks[label] = new_block_body

                colors = set(home.values())

                used_callee = [Reg("rbp")]

                num_spilled_to_root = len(spilled_to_root)
                stack_size = len(spilled_to_procedure_stack) * 8

                for color, reg in [
                    (7, Reg("rbx")),
                    (8, Reg("r12")),
                    (9, Reg("r13")),
                    (10, Reg("r14")),
                ]:
                    if color in colors:
                        used_callee.append(reg)
                new_def = FunctionDef(name, [], new_blocks, None, returns, None)
                new_def.stack_size = stack_size
                new_def.used_callee = used_callee
                new_def.num_spilled_to_root = num_spilled_to_root
                return new_def

    def assign_homes(self, p: X86ProgramDefs) -> X86ProgramDefs:
        match p:
            case X86ProgramDefs(defs):
                new_defs = [self.assign_homes_function(f) for f in defs]
                return X86ProgramDefs(new_defs)

    ############################################################################
    # Patch Instructions
    ############################################################################

    def patch_instr(self, i: instr) -> list[instr]:
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
            case Instr("leaq", [arg0, arg1]):
                match (arg0, arg1):
                    case (_, Deref()):
                        return [
                            Instr("leaq", [arg0, Reg("rax")]),
                            Instr("movq", [Reg("rax"), arg1])
                        ]
                    case _:
                        return [i]
            case TailJump(arg0, arity):
                match arg0:
                    case Reg("rax"):
                        return [i]
                    case _:
                        return [
                            Instr("movq", [arg0, Reg("rax")]),
                            TailJump(Reg("rax"), arity)
                        ]
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
    
    def patch_function(self, f: FunctionDef) -> FunctionDef:
        match f:
            case FunctionDef(name, _, basic_blocks, _, returns):
                new_blocks = {}
                for label, block in basic_blocks.items():
                    new_block_body = []
                    for instr in block:
                        new_block_body += self.patch_instr(instr)
                    new_blocks[label] = new_block_body
                new_def = FunctionDef(name, [], new_blocks, None, returns, None)
                new_def.stack_size = f.stack_size
                new_def.used_callee = f.used_callee
                new_def.num_spilled_to_root = f.num_spilled_to_root
                return new_def

    def patch_instructions(self, p: X86ProgramDefs) -> X86ProgramDefs:
        match p:
            case X86ProgramDefs(defs):
                new_defs = [self.patch_function(f) for f in defs]
                return X86ProgramDefs(new_defs)

    ############################################################################
    # Prelude & Conclusion
    ############################################################################

    def prelude_and_conclusion(self, p: X86ProgramDefs) -> X86Program:
        match p:
            case X86ProgramDefs(defs):
                all_blocks = {}
                for function in defs:
                    match function:
                        case FunctionDef(name, _, basic_blocks):
                            stack_space = function.stack_size
                            used_callee = function.used_callee
                            root_spilled = function.num_spilled_to_root

                            align = lambda x: x + 8 if x % 16 != 0 else x
                            used_by_callee = len(used_callee) * 8 - 8
                            stack_space = align(stack_space + used_by_callee) - used_by_callee

                            new_basic_blocks = {}

                            
                            for label, ss in basic_blocks.items():
                                if len(ss) == 0:
                                    continue

                                *ss, tail = ss
                                
                                match tail:
                                    case TailJump(callee):
                                        pop_frame = [
                                            Instr("subq", [Immediate(root_spilled * 8), Reg("r15")]),
                                            Instr("addq", [Immediate(stack_space), Reg("rsp")]),
                                            *[
                                                Instr("popq", [callee_saved_reg])
                                                for callee_saved_reg in reversed(used_callee)
                                            ],
                                            IndirectJump(callee)
                                        ]
                                        new_basic_blocks[label] = ss + pop_frame
                                    case _:
                                        new_basic_blocks[label] = ss + [tail]

                            prelude = [
                                *[
                                    Instr("pushq", [callee_saved_reg])
                                    for callee_saved_reg in used_callee
                                ],
                                Instr("movq", [Reg("rsp"), Reg("rbp")]),
                                Instr("subq", [Immediate(stack_space), Reg("rsp")])
                            ]
                            if name == 'main':
                                prelude += [
                                    Instr("movq", [Immediate(self.root_size), Reg("rdi")]),
                                    Instr("movq", [Immediate(self.heap_size), Reg("rsi")]),
                                    Callq("initialize", 2),
                                    Instr("movq", [Global("rootstack_begin"), Reg("r15")]),
                                ]
                            prelude += [
                                Instr("addq", [Immediate(root_spilled * 8), Reg("r15")]),
                                *[
                                    Instr("movq", [Immediate(0), Deref("r15", i * 8)])
                                    for i in range(root_spilled)
                                ],
                                Jump(label_block_start(name)),
                            ]

                            conclusion = [
                                Instr("subq", [Immediate(root_spilled * 8), Reg("r15")]),
                                Instr("addq", [Immediate(stack_space), Reg("rsp")]),
                                *[
                                    Instr("popq", [callee_saved_reg])
                                    for callee_saved_reg in reversed(used_callee)
                                ],
                                Instr("retq", []),
                            ]

                            new_basic_blocks[label_name(name)] = prelude
                            new_basic_blocks[label_block_conclusion(name)] = conclusion

                            all_blocks.update(new_basic_blocks)

                return X86Program(all_blocks)
