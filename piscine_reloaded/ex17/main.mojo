from std.sys.arg import argv
from libft.string import ft_atoi, ft_itoa

def power(b: Int, e: Int) -> Int:
    if e < 0:
        return 0
    if e == 0:
        return 1
    return b * power(b, e - 1)

def main():
    var args = argv()
    if len(args) >= 3:
        print(ft_itoa(power(ft_atoi(args[1]), ft_atoi(args[2]))))
