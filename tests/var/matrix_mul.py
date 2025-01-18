# A, m x n
A = [[1, 2], [3, 4], [9, 11]]
# B, n x p
B = [[5, 6, 6], [7, 8, 12]]

m = len(A)
n = len(A[0])
p = len(B[0])

print(m)
print(n)
print(p)

# R, m x p
R = [[0, 0, 0], [0, 0, 0], [0, 0, 0]]

i = 0
while i < m:
    j = 0
    while j < p:
        k = 0
        r = 0
        while k < n:
            r = r + (A[i][k] * B[k][j])
            k = k + 1
        R[i][j] = r
        j = j + 1
    i = i + 1

# printing
i = 0
while i < m:
    j = 0
    while j < p:
        print(R[i][j])
        j = j + 1
    i = i + 1

print(len(R))
print(len(R[0]))
print(m)
print(n)
print(p)
