j = 8
a = (
    -(4 if j == 2 else j - 2)
    if (((not (input_int() > 6)) and input_int() < 127) or input_int() == 4)
    else (1 if (True if (2 < 4) else True) else 2)
)
print(a)
