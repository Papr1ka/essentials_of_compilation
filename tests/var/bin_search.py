# Отсортированный массив
a = [
    -30,
    -26,
    -26,
    -22,
    -19,
    -15,
    -12,
    -10,
    -9,
    -8,
    0,
    0,
    2,
    7,
    20,
    29,
    30,
    31,
    32,
    32,
    38,
    38,
    43,
    46,
    48,
]

# искомое число
value = input_int()

# индексы первого элемента, последнего и среднего
low = 0
high = len(a) - 1
mid = 12

while a[mid] != value and low <= high:
    if value > a[mid]:
        low = mid + 1
    else:
        high = mid - 1
    temp_mid = low + high

    # Целочисленное деление на 2
    mid = 0
    while temp_mid >= 2:
        temp_mid = temp_mid - 2
        mid = mid + 1

if low > high:
    print(-1)
else:
    print(mid)
