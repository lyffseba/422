from std.sys.arg import argv
from libft.string import ft_atoi

def main():
    var args = argv()
    if len(args) < 2:
        return
    var n = ft_atoi(args[1])
    if n < 0:
        print("N")
    else:
        print("P")
