x = input_int()
is_even = True
i = 0
while i < x:
    is_even = not is_even
    i = i + 1
if is_even:
    print(1)
else:
    print(0)
