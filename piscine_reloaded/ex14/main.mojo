from std.sys.arg import argv
from libft.string import ft_atoi, ft_itoa

def factorial(n: Int) -> Int:
    if n < 0:
        return 0
    var r = 1
    var i = 2
    while i <= n:
        r *= i
        i += 1
    return r

def main():
    var args = argv()
    if len(args) >= 2:
        print(ft_itoa(factorial(ft_atoi(args[1]))))
