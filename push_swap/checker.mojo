from std.sys.arg import argv
from std.pathlib import Path
from libft.string import ft_atoi, byte_at
from push_swap.stack import Piles

def read_stdin_lines() raises -> List[String]:
    # checker reads instructions from a file path "-" meaning we use /dev/stdin if present
    # For portability, accept optional @file via env; default try Path("/dev/stdin")
    var text = String("")
    try:
        text = Path("/dev/stdin").read_text()
    except e:
        return List[String]()
    var lines = List[String]()
    var cur = String()
    var i = 0
    while i < text.byte_length():
        var c = byte_at(text, i)
        if c == ord("\n"):
            if cur.byte_length() > 0:
                lines.append(cur)
            cur = String()
        else:
            cur += chr(c)
        i += 1
    if cur.byte_length() > 0:
        lines.append(cur)
    return lines^

def main() raises:
    var args = argv()
    if len(args) < 2:
        return
    var vals = List[Int]()
    var i = 1
    while i < len(args):
        var v = ft_atoi(args[i])
        var j = 0
        while j < len(vals):
            if vals[j] == v:
                print("Error")
                return
            j += 1
        vals.append(v)
        i += 1
    var p = Piles(vals)
    # clear recorded ops from construction side effects — none
    p.ops = List[String]()
    var lines = read_stdin_lines()
    i = 0
    while i < len(lines):
        try:
            # apply without wanting double count — use apply which records; fine
            p.apply(lines[i])
        except e:
            print("Error")
            return
        i += 1
    # strip recording
    if p.is_sorted():
        print("OK")
    else:
        print("KO")
