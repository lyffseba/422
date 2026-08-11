from std.sys.arg import argv
from libft.string import ft_strcmp, ft_itoa

def main():
    var args = argv()
    if len(args) >= 3:
        print(ft_itoa(ft_strcmp(args[1], args[2])))
