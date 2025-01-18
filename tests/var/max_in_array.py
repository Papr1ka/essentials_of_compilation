arr = [10, 20, 5, 30, 15]
max_value = arr[0]
i = 1
while i < len(arr):
    if arr[i] > max_value:
        max_value = arr[i]
    i = i + 1
print(max_value)
