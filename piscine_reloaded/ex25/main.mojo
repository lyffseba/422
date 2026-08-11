from std.sys.arg import argv
from libft.string import ft_split

def main():
    var args = argv()
    if len(args) < 2:
        return
    var parts = ft_split(args[1], ord(" "))
    var i = 0
    while i < len(parts):
        print(parts[i])
        i += 1
