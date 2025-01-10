a = input_int()
b = input_int()
if a == b:
    print(a)
else:
    if a > b:
        a = a - b
    else:
        b = b - a
    if a == b:
        print(a)
    else:
        if a > b:
            a = a - b
        else:
            b = b - a
        if a == b:
            print(a)
        else:
            if a > b:
                a = a - b
            else:
                b = b - a
            print(a)
