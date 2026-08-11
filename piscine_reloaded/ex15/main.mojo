from std.sys.arg import argv
from libft.string import ft_atoi, ft_itoa

def factorial(n: Int) -> Int:
    if n < 0:
        return 0
    if n <= 1:
        return 1
    return n * factorial(n - 1)

def main():
    var args = argv()
    if len(args) >= 2:
        print(ft_itoa(factorial(ft_atoi(args[1]))))
