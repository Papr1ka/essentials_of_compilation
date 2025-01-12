# факториал
n = input_int()
fact = 1

while n > 0:
    # умножение, a * b = res
    a = fact
    b = n
    res = 0
    while b > 0:
        res = res + a
        b = b - 1
    n = n - 1
    fact = res

print(fact)
