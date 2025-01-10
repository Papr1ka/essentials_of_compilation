a = input_int() == 0
b = input_int() == 1
a = not a
b = not a
c = (not a) and (not b)
d = (not a) or (not b)
d = not d
c = not d
print(1 if c == True else 0)
