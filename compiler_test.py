import ast
from compiler import Compiler
from graph import topological_stable_sort, transpose
import interp_Larray
from type_check_Carray import TypeCheckCarray
from type_check_Cfun import TypeCheckCfun
from type_check_Larray import TypeCheckLarray
from type_check_Lfun import TypeCheckLfun

if __name__ == "__main__":
    program = """
def add(x:int, y:int) -> int:
    return x + y

print(add(40, 2))
"""
    
#     program = """
# def map(f : Callable[[int], int], v : tuple[int,int]) -> tuple[int,int]:
#     return f(v[0]), f(v[1])

# def inc(x : int) -> int:
#     return x + 1

# def test(f: Callable[[], Callable[[int], int]]) -> Callable[[int], int]:
#     return inc

# f = test()
# print(map(f, (0, 41))[1])
# """
#     program = """
# def map(f : Callable[[int], int], v : tuple[int,int]) -> tuple[int,int]:
#     return inc(v[0]), inc(v[1])

# def inc(x : int) -> int:
#     return x + 1

# print(map(inc, (0, 41))[1])
# """

#     program = """
# def sum10(a: int, b: int, c: int, d: int, e: int, f: int, g: int, h: int, i: int, j: int) -> int:
#     return a + b + c + d + e + f + g + h + i + j

# def sum7(a: int, b: int, c: int, d: int, e: int, f: int, g: int) -> int:
#     return a + b + c + d + e + f + g

# def sum6(a: int, b: int, c: int, d: int, e: int, f: int) -> int:
#     return a + b + c + d + e + f

# def sum5(a: int, b: int, c: int, d: int, e: int) -> int:
#     return a + b + c + d + e

# print(sum5(1, 2, 3, 4, 5))
# print(sum6(1, 2, 3, 4, 5, 6))
# print(sum7(1, 2, 3, 4, 5, 6, 7))
# print(sum10(1, 2, 3, 4, 5, 6, 7, 8, 9, 10))
# """
#     program = """
# def test(x: int) -> int:
#     return 2 if x > 0 else 3

# print(test(-4))
# """
#     program = """
# def add(x:int, y:int) -> int:
#     return x + y
# print(add(40, 2))
# """
#     program = """
# def tail_sum(n : int, r : int) -> int:
#     if n == 0:
#         return r
#     else:
#         return tail_sum(n - 1, n + r)
# print(tail_sum(3, 0) + 36)
# """
    tree = ast.parse(program)

    print("\n #Source AST of the program\n")
    print(program)
    print(repr(program))
    print(ast.dump(tree, indent=2))

    # interp_Larray.InterpLarray().interp(tree)
    print()

    compiler = Compiler()

    TypeCheckLfun().type_check(tree)

    tree = compiler.shrink(tree)
    print("\n #After shrink\n")
    print(tree)
    print()


    tree = compiler.reveal_functions(tree)
    print("\n #After reveal functions\n")
    print(tree)
    print()

    TypeCheckLfun().type_check(tree)

    tree = compiler.resolve(tree)
    print("\n #After resolve\n")
    print(tree)
    print()

    TypeCheckLfun().type_check(tree)

    tree = compiler.check_bounds(tree)
    print("\n #After check bounds\n")
    print(tree)
    print()


    tree = compiler.limit_functions(tree)
    print("\n #After limit functions\n")
    print(tree)
    print()


    TypeCheckLfun().type_check(tree)

    tree = compiler.expose_allocation(tree)
    print("\n #After expose allocation\n")
    print(tree)
    print()

    tree = compiler.remove_complex_operands(tree)
    print("\n #After removing complex operans\n")
    print(tree)
    print()
    print(repr(tree))
    print()

    tree = compiler.explicate_control(tree)
    print("\n #After explicate control\n")
    print(tree)
    print()

    TypeCheckCfun().type_check(tree)

    x86_program = compiler.select_instructions(tree)
    print("\n #After selecting instructions\n")
    print(x86_program)

    for f in x86_program.defs:
        g = compiler.build_cfg(f.body)
        g.show(engine="dot").save(f"cfg_{f.name}.dot")
        ordering = topological_stable_sort(g)
        print(ordering)

    x86_program = compiler.remove_jumps(x86_program)
    print("\n #After remove jumps\n")
    print(x86_program)

    print("Liveless analysys")
    for f in x86_program.defs:
        mapping = compiler.uncover_live(f)
        for label, block in f.body.items():
            print(f"{label}:")
            for instr in block:
                print(f"{instr}, (({", ".join(map(str, mapping[instr]))}))")

    for f in x86_program.defs:
        variables = compiler.collect_vars(f.body)
        interference_graph = compiler.build_interference(f)
        interference_graph.show().save(f"interference_{f.name}.dot")

        move_graph = compiler.build_move_graph(f)
        move_graph.show().save(f"move_{f.name}.dot")

        mapping = compiler.color_graph(
            interference_graph,
            variables,
            move_graph,
        )
        print("the Mapping:")
        print(mapping)

    x86_program = compiler.assign_homes(x86_program)
    print("\n #After assigning homes\n")
    print(x86_program)

    x86_program = compiler.patch_instructions(x86_program)
    print("\n #After patching instructions\n")
    print(x86_program)

    x86_program = compiler.prelude_and_conclusion(x86_program)
    print("\n# Result\n")
    print(x86_program)

    with open("cp.s", "w") as file:
        file.write(str(x86_program))

    exit(0)
