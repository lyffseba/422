from std.sys.arg import argv

def ft_putstr(s: String):
    print(s, end="")

def main():
    var args = argv()
    if len(args) >= 2:
        ft_putstr(args[1])
        print()
