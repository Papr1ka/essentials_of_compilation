fib = (0, 1)

i = 0
while i < 10 - 2:
    fib = (fib[1], fib[0] + fib[1])
    i = i + 1

print(fib[0] + fib[1])
