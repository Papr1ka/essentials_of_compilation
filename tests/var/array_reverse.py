arr = [input_int(), input_int(), input_int(), input_int(), input_int()]
reverse = [0, 0, 0, 0, 0]

i = 0
while i < len(arr):
    reverse[len(reverse) - i - 1] = arr[i]
    i = i + 1

i = 0
while i < len(reverse):
    print(reverse[i])
    i = i + 1
