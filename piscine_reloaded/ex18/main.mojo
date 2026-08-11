from std.sys.arg import argv
from libft.string import ft_atoi, ft_itoa

def fib(n: Int) -> Int:
    if n < 0:
        return -1
    if n < 2:
        return n
    return fib(n - 1) + fib(n - 2)

def main():
    var args = argv()
    if len(args) >= 2:
        print(ft_itoa(fib(ft_atoi(args[1]))))
