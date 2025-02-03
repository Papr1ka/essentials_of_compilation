def exchange(s: int, res: list[int]):
    if s >= 5:
        res[2] = res[2] + 1
        return exchange(s - 5, res)
    elif s >= 2:
        res[1] = res[1] + 1
        return exchange(s - 2, res)
    elif s >= 1:
        res[0] = res[0] + 1
        return exchange(s - 1, res)

def print_array(arr: list[int]):
    i = 0
    while i < len(arr):
        print(arr[i])
        i = i + 1

# coins 1, 2, 5
amount = input_int()
res = [0, 0, 0]
exchange(amount, res)
print_array(res)
