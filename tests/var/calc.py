a = input_int()
b = input_int()
sum = a + b
diff = a - b
if sum > diff:
    print(sum)
else:
    print(diff)
result = sum if sum > diff else diff
print(result)
