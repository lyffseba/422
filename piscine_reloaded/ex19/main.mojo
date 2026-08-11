from std.sys.arg import argv
from libft.string import ft_atoi, ft_itoa

def ft_sqrt(n: Int) -> Int:
    if n < 0:
        return 0
    var i = 0
    while i * i <= n:
        if i * i == n:
            return i
        i += 1
    return 0

def main():
    var args = argv()
    if len(args) >= 2:
        print(ft_itoa(ft_sqrt(ft_atoi(args[1]))))
