from std.sys.arg import argv
from libft.string import ft_atoi, ft_itoa

def power(b: Int, e: Int) -> Int:
    if e < 0:
        return 0
    var r = 1
    var i = 0
    while i < e:
        r *= b
        i += 1
    return r

def main():
    var args = argv()
    if len(args) >= 3:
        print(ft_itoa(power(ft_atoi(args[1]), ft_atoi(args[2]))))
