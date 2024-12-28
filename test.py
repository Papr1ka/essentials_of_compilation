import ast

arg0 = ast.Name("b")
arg1 = ast.Name("a")
target = "a"

# Представим, что у нас есть выражение a = a + b
# Исходя из имён аргументов выражения, мы пожем выбрать 2 пути преобразования
# Если один из аргументов появляется в выражении ещё и как переменная для записи результата
# (a = a + b) или (a = b + a)
# Мы может оттранслировать выражение в одну команду 'addq b a'

# Иначе нам потребуется 2 команды
# movq b a
# addq c a
# (a = b + c)

# movq c a
# addq b a
# (a = c + b)

# Возможно ли реализовать такую проверку в 1 паттерн match case-а?


def test(var0, var1):
    match (var0, var1):
        ##### код сюда ############################################################
        # Проверка на то, что один из агрументов
        # 1. Является переменной
        # 2. Назван также, как target
        case (ast.Name(var_arg), _) | (_, ast.Name(var_arg)) if var_arg == target:
            print("easy way, without movq")
        ############################################################################

        case _:
            print("hard way, movq is necessary")


test(arg0, arg0)  # a = b, b, expected: hard  actual: hard
test(arg0, arg1)  # a = b, a  expected: easy  actual: hard
test(arg1, arg0)  # a = a, b  expected: easy  actual: easy
test(arg1, arg1)  # a = a, a  expected: easy  actual: easy
