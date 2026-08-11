"""Memory-oriented helpers (42 libft mem* family, Mojo-safe)."""

def ft_memset_list(mut dst: List[Int], value: Int, n: Int):
    var i = 0
    var lim = n
    if lim > len(dst):
        lim = len(dst)
    while i < lim:
        dst[i] = value
        i += 1

def ft_memcpy_list(src: List[Int]) -> List[Int]:
    var out = List[Int]()
    var i = 0
    while i < len(src):
        out.append(src[i])
        i += 1
    return out^

def ft_memcmp_list(a: List[Int], b: List[Int], n: Int) -> Int:
    var i = 0
    while i < n:
        if i >= len(a) and i >= len(b):
            return 0
        if i >= len(a):
            return -1
        if i >= len(b):
            return 1
        if a[i] != b[i]:
            return a[i] - b[i]
        i += 1
    return 0

def ft_swap_int(mut a: Int, mut b: Int):
    var t = a
    a = b
    b = t
