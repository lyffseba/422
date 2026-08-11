from std.sys.arg import argv
from libft.string import byte_at
from libft.ctype import ft_isprint

def main():
    var args = argv()
    if len(args) < 2:
        return
    var s = args[1]
    var i = 0
    while i < s.byte_length():
        var c = byte_at(s, i)
        if ft_isprint(c):
            print(chr(c), end="")
        else:
            print(".", end="")
        i += 1
    print()
