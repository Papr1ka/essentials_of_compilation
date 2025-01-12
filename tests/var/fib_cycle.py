n = input_int()
a = 0
b = 1
c = 0
if n == 1:
    print(1)
else:
    if n < 0:
        while n < 0:
            c = b - a
            b = a
            a = c
            n = n + 1
    else:
        n = n - 1
        while n > 0:
            c = a + b
            a = b
            b = c
            n = n - 1
    print(c)
