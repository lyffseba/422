"""fdf — ASCII wireframe height-map renderer."""

from std.pathlib import Path
from libft.string import byte_at, ft_atoi, ft_split

def parse_map(text: String) raises -> List[List[Int]]:
    var grid = List[List[Int]]()
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
    i = 0
    while i < len(lines):
        var parts = ft_split(lines[i], ord(" "))
        var row = List[Int]()
        var j = 0
        while j < len(parts):
            if parts[j].byte_length() > 0:
                row.append(ft_atoi(parts[j]))
            j += 1
        if len(row) > 0:
            grid.append(row^)
        i += 1
    if len(grid) == 0:
        raise Error("empty map")
    return grid^

def set_cell(mut b: List[String], x: Int, y: Int, ch: String):
    if y < 0 or y >= len(b) or x < 0 or x >= b[y].byte_length():
        return
    var row = String()
    var i = 0
    while i < b[y].byte_length():
        if i == x:
            row += ch
        else:
            row += chr(byte_at(b[y], i))
        i += 1
    b[y] = row^

def render_ascii(grid: List[List[Int]]) -> String:
    var h = len(grid)
    var w = len(grid[0])
    var out_h = h * 2 + w
    var out_w = w * 4 + h * 2 + 4
    if out_h < 8:
        out_h = 8
    if out_w < 16:
        out_w = 16
    var buf = List[String]()
    var y = 0
    while y < out_h:
        var row = String()
        var x = 0
        while x < out_w:
            row += " "
            x += 1
        buf.append(row^)
        y += 1

    var gy = 0
    while gy < h:
        var gx = 0
        while gx < w:
            var z = grid[gy][gx]
            var px = gx * 3 + gy * 2 + 2
            var py = gy + (w // 4) - z + h
            var ch = String(".")
            if z > 0:
                ch = String("^")
            if z > 2:
                ch = String("A")
            if z > 5:
                ch = String("#")
            set_cell(buf, px, py, ch)
            if gx + 1 < w:
                set_cell(buf, px + 1, py, "-")
            if gy + 1 < h:
                set_cell(buf, px, py + 1, "|")
            gx += 1
        gy += 1

    var out = String()
    y = 0
    while y < len(buf):
        var row2 = buf[y]
        var end = row2.byte_length()
        while end > 0 and byte_at(row2, end - 1) == ord(" "):
            end -= 1
        if end > 0:
            var i = 0
            while i < end:
                out += chr(byte_at(row2, i))
                i += 1
            out += "\n"
        y += 1
    return out^

def render_file(path: String) raises -> String:
    var text = Path(path).read_text()
    var grid = parse_map(text)
    return render_ascii(grid)
