from std.sys.arg import argv
from libft.string import ft_atoi, ft_itoa

def ft_abs(n: Int) -> Int:
    if n < 0:
        return -n
    return n

def main():
    var args = argv()
    if len(args) >= 2:
        print(ft_itoa(ft_abs(ft_atoi(args[1]))))
