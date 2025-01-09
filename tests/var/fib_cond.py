count = input_int()
a = 2
b = 3
c = b

if count > 0:
    c = a + b
    a = b
    b = c
    count = count - 1
    if count > 0:
        c = a + b
        a = b
        b = c
        count = count - 1
        if count > 0:
            c = a + b
            a = b
            b = c
            count = count - 1
        else:
            print(c)
    else:
        print(c)
else:
    print(c)
