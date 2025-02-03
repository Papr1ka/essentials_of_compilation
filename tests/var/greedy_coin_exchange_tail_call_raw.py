def exchange(s: int, c1: int, c2: int, c5: int) -> tuple[int, int, int]:
    if s == 0:
        return (c1, c2, c5)
    if s >= 5:
        return exchange(s - 5, c1, c2, c5 + 1)
    elif s >= 2:
        return exchange(s - 2, c1, c2 + 1, c5)
    else:
        return exchange(s - 1, c1 + 1, c2, c5)

# coins 1, 2, 5
amount = input_int()
coins = exchange(amount, 0, 0, 0)
print(coins[0])
print(coins[1])
print(coins[2])
