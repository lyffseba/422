from std.sys.arg import argv
from std.pathlib import Path
from libft.string import byte_at, ft_itoa

def main() raises:
    var args = argv()
    if len(args) < 2:
        return
    var text = Path(args[1]).read_text()
    var n = 0
    var i = 0
    while i < text.byte_length():
        if byte_at(text, i) == ord("\n"):
            n += 1
        i += 1
    if text.byte_length() > 0 and byte_at(text, text.byte_length() - 1) != ord("\n"):
        n += 1
    print(ft_itoa(n))
