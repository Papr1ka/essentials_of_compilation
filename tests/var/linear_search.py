arr = [1, 2, 5, 10, -4, 15, 2, 9, 42, 89, 90, 6, 3, 2, 0, 15, 104]
target = input_int()
i = 0
is_founded = False
while i < len(arr) and not is_founded:
    if arr[i] == target:
        print(i)
        is_founded = True
    else:
        i = i + 1
