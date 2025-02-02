def map(f : Callable[[int], int], v : tuple[int,int]) -> tuple[int,int]:
    return f(v[0]), f(v[1])

def inc(x : int) -> int:
    return x + 1

def test(f: Callable[[], Callable[[int], int]]) -> Callable[[int], int]:
    return inc

f = test()
print(map(f, (0, 41))[1])
