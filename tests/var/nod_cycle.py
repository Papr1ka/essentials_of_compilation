# a = 2 * 3 * 7 * 4
a = 2184
# b = 7 * 4 * 5
b = 140
while a != b:
    if a > b:
        a = a - b
    else:
        b = b - a
print(a)
