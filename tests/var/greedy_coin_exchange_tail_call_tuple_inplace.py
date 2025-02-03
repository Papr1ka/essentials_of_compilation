def exchange(s: int, res: tuple[int, int, int]) -> tuple[int, int, int]:
    if s == 0:
        return res
    if s >= 5:
        res[2] = res[2] + 1
        return exchange(s - 5, res)
    elif s >= 2:
        res[1] = res[1] + 1
        return exchange(s - 2, res)
    else:
        res[0] = res[0] + 1
        return exchange(s - 1, res)

def print_coins(tup: tuple[int, int, int]):
    print(tup[0])
    print(tup[1])
    print(tup[2])

# coins 1, 2, 5
amount = input_int()
print_coins(exchange(amount, (0, 0, 0)))
