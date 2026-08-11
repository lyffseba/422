from std.sys.arg import argv
from std.pathlib import Path

def main() raises:
    var args = argv()
    if len(args) != 2:
        if len(args) < 2:
            print("File name missing.")
        else:
            print("Too many arguments.")
        return
    try:
        print(Path(args[1]).read_text(), end="")
    except e:
        print("Cannot read file.")
