def bubble_sort_inplace(array: list[int]):
    left = 0
    while left < len(array):
        right = left + 1
        while right < len(array):
            x = array[left]
            y = array[right]
            if (y < x):
                array[left] = y
                array[right] = x
            right = right + 1

        left = left + 1

def min(a: int, b: int) -> int:
    return a if a < b else b

def max(a: int, b: int) -> int:
    return a if a > b else b

def getMinDiff(arr: list[int], k: int) -> int:
    n = len(arr)
    bubble_sort_inplace(arr)

    # If we increase all heights by k or decrease all
    # heights by k, the result will be arr[n - 1] - arr[0]
    res = arr[n - 1] - arr[0]

    # For all indices i, increment arr[0...i-1] by k and
    # decrement arr[i...n-1] by k
    i = 1
    while i < len(arr):
        # Impossible to decrement height of ith tower by k, 
        # continue to the next towers
        if arr[i] - k >= 0:
            # Minimum height after modification
            minH = min(arr[0] + k, arr[i] - k)

            # Maximum height after modification
            maxH = max(arr[i - 1] + k, arr[n - 1] - k)

            # Store the minimum difference as result
            res = min(res, maxH - minH)
        i = i + 1
    return res

# Python program to minimize the maximum difference
# between heights using Sorting

k = 6
arr = [12, 6, 4, 15, 17, 10]

ans = getMinDiff(arr, k)
print(ans)
