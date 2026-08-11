from std.sys.arg import argv
from std.pathlib import Path
from libft.string import byte_at
from push_swap.stack import Piles, parse_int_list

def read_instruction_lines() raises -> List[String]:
    var text = Path("/dev/stdin").read_text()
    var lines = List[String]()
    var cur = String()
    var i = 0
    while i < text.byte_length():
        var c = byte_at(text, i)
        if c == ord("\n"):
            if cur.byte_length() > 0:
                lines.append(cur^)
            cur = String()
        else:
            cur += chr(c)
        i += 1
    if cur.byte_length() > 0:
        lines.append(cur^)
    return lines^

def main() raises:
    var args = argv()
    if len(args) < 2:
        return
    try:
        var tokens = List[String]()
        var i = 1
        while i < len(args):
            tokens.append(String(args[i]))
            i += 1
        var vals = parse_int_list(tokens)
        var p = Piles(vals)
        p.record = False
        var lines = read_instruction_lines()
        i = 0
        while i < len(lines):
            p.apply(lines[i])
            i += 1
        if p.is_sorted():
            print("OK")
        else:
            print("KO")
    except e:
        print("Error")
