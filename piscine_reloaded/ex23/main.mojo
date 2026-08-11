from std.sys.arg import argv
from libft.string import ft_atoi, ft_itoa

def main():
    var args = argv()
    if len(args) < 2:
        return
    var m = ft_atoi(args[1])
    var i = 2
    while i < len(args):
        var v = ft_atoi(args[i])
        if v > m:
            m = v
        i += 1
    print(ft_itoa(m))
