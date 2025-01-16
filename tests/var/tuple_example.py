# t = (40, True, (2,))
# print(t[0] + t[2][0] if t[1] else 44)

t = (42, True, 2)
print(t[0])

t1 = (3, 7)
t2 = t1
t3 = (3, 7)
print(42 if (t1 is t2) and not (t1 is t3) else 0)

v1 = (42,)
v2 = (v1,)
print(v2[0][0])
