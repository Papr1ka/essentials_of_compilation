import ast
from compiler import Compiler
from graph import topological_stable_sort, transpose
import type_check_Ctup
from type_check_Ltup import TypeCheckLtup


if __name__ == "__main__":
    program = """
v1 = (42,)
v2 = (v1,)
print(v2[0][0])
"""
    program = """
fib = (0, 1)

i = 0
while i < 10:
    fib = (fib[1], fib[0] + fib[1])
    i = i + 1

print(fib[0] + fib[1])
"""
    #     program = """
    # x = input_int()
    # y = input_int()
    # print(x + y)
    # """
    tree = ast.parse(program)

    print("\n #Source AST of the program\n")
    print(program)
    # print(ast.dump(tree, indent=2))

    compiler = Compiler()

    tree = compiler.shrink(tree)
    # print("\n #After shrink\n")
    # print(tree)
    # print()

    TypeCheckLtup().type_check(tree)

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

    type_check_Ctup.TypeCheckCtup().type_check(tree)

    x86_program = compiler.select_instructions(tree)
    print("\n #After selecting instructions\n")
    print(x86_program)

    g = compiler.build_cfg(x86_program)
    g.show(engine="dot").save("cfg.dot")
    ordering = topological_stable_sort(g)
    print(ordering)

    x86_program = compiler.remove_jumps(x86_program)
    print("\n #After remove jumps\n")
    print(x86_program)

    print("Liveless analysys")
    mapping = compiler.uncover_live(x86_program)
    for label, block in x86_program.body.items():
        print(f"{label}:")
        for instr in block:
            print(f"{instr}, (({", ".join(map(str, mapping[instr]))}))")

    variables = compiler.collect_vars(x86_program)
    print(variables)
    interference_graph = compiler.build_interference(x86_program)
    interference_graph.show().save("interference.dot")

    move_graph = compiler.build_move_graph(x86_program)
    move_graph.show().save("move.dot")

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
