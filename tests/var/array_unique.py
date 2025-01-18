arr = [
    6,
    4,
    7,
    10,
    6,
    1,
    -8,
    7,
    -2,
    4,
    7,
    7,
    5,
    7,
    0,
    -10,
    4,
    7,
    -10,
    1,
    -2,
    0,
    -4,
    5,
    1,
]

unique_count = 0
i = 0

while i < len(arr):
    is_unique = True
    j = 0
    while j < i:
        if arr[i] == arr[j]:
            is_unique = False
        j = j + 1
    if is_unique:
        unique_count = unique_count + 1
    i = i + 1
print(unique_count)
