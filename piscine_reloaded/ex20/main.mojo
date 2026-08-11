from std.sys.arg import argv
from libft.string import ft_atoi, ft_itoa

def main():
    var args = argv()
    if len(args) >= 3:
        var a = ft_atoi(args[1])
        var b = ft_atoi(args[2])
        if b == 0:
            print("Error")
            return
        print(ft_itoa(a // b))
        print(ft_itoa(a % b))
