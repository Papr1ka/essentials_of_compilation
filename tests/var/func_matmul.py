def matmul(a: list[list[int]], b: list[list[int]], c: list[list[int]]) -> None:
    m = len(a)
    n = len(a[0])
    p = len(b[0])

    i = 0
    while i < m:
        j = 0
        while j < p:
            k = 0
            r = 0
            while k < n:
                r = r + (a[i][k] * b[k][j])
                k = k + 1
            c[i][j] = r
            j = j + 1
        i = i + 1

def print_matrix(a: list[list[int]]):
    m = len(a)
    p = len(a[0])
    i = 0
    while i < m:
        j = 0
        while j < p:
            print(a[i][j])
            j = j + 1
        i = i + 1

# A, m x n
A = [[1, 2], [3, 4], [9, 11]]
# B, n x p
B = [[5, 6, 6], [7, 8, 12]]
# R, m x p
R = [[0, 0, 0], [0, 0, 0], [0, 0, 0]]

# Result to R
matmul(A, B, R)
print_matrix(R)
