from std.sys.arg import argv
from libft.string import ft_atoi, ft_itoa

def ft_range(start: Int, end: Int) -> List[Int]:
    var out = List[Int]()
    var i = start
    if start <= end:
        while i < end:
            out.append(i)
            i += 1
    else:
        while i > end:
            out.append(i)
            i -= 1
    return out^

def main():
    var args = argv()
    if len(args) >= 3:
        var r = ft_range(ft_atoi(args[1]), ft_atoi(args[2]))
        var i = 0
        while i < len(r):
            print(ft_itoa(r[i]))
            i += 1
