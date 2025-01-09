a = input_int()
b = input_int()
c = input_int()
max_value = a if a > b else b
max_value = max_value if max_value > c else c
print(max_value)
