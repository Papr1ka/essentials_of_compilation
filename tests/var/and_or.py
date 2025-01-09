a = True
b = False
c = False
d = True
e = False
if (c or d) or a:
    print(0)
else:
    print(1)

if d and (a or input_int() == 4):
    print(2)
else:
    print(3)

if e and d:
    print(5)
else:
    print(6)

if ((input_int() + 1) == 5 and (input_int() - 4) == 0) and input_int() == 8:
    print(7)
else:
    print(8)

if ((input_int() + 1) == 5 or (input_int() - 4) == 0) or (
    input_int() == 8 or input_int() == 9
):
    print(9)
else:
    print(10)

if input_int() < input_int():
    if a and b:
        print(11)
    else:
        print(12)
else:
    print(13)
