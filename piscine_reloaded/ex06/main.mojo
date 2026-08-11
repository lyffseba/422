from std.sys.arg import argv
from libft.string import ft_strlen, ft_itoa

def main():
    var args = argv()
    if len(args) >= 2:
        print(ft_itoa(ft_strlen(args[1])))
