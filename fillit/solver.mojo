"""Fillit — pack tetriminos on the smallest square (backtracking)."""

from std.pathlib import Path
from libft.string import byte_at

@fieldwise_init
struct Point(Copyable, Movable):
    var x: Int
    var y: Int

struct Tetromino(Copyable, Movable):
    var cells: List[Point]
    var letter: String

    def __init__(out self, var cells: List[Point], letter: String):
        self.cells = cells^
        self.letter = letter

def parse_piece(block: String, letter: String) raises -> Tetromino:
    var cells = List[Point]()
    var rows = List[String]()
    var cur = String()
    var i = 0
    while i < block.byte_length():
        var c = byte_at(block, i)
        if c == ord("\n"):
            rows.append(cur^)
            cur = String()
        else:
            cur += chr(c)
        i += 1
    if cur.byte_length() > 0:
        rows.append(cur^)
    if len(rows) != 4:
        raise Error("invalid piece rows")
    var y = 0
    while y < 4:
        if rows[y].byte_length() != 4:
            raise Error("invalid piece cols")
        var x = 0
        while x < 4:
            var ch = byte_at(rows[y], x)
            if ch == ord("#"):
                cells.append(Point(x, y))
            elif ch != ord("."):
                raise Error("invalid char")
            x += 1
        y += 1
    if len(cells) != 4:
        raise Error("piece must have 4 blocks")
    var min_x = cells[0].x
    var min_y = cells[0].y
    var k = 1
    while k < 4:
        if cells[k].x < min_x:
            min_x = cells[k].x
        if cells[k].y < min_y:
            min_y = cells[k].y
        k += 1
    var norm = List[Point]()
    k = 0
    while k < 4:
        norm.append(Point(cells[k].x - min_x, cells[k].y - min_y))
        k += 1
    return Tetromino(norm^, letter)

def parse_file(path: String) raises -> List[Tetromino]:
    var text = Path(path).read_text()
    var pieces = List[Tetromino]()
    var block = String()
    var i = 0
    var letter_i = 0
    while i < text.byte_length():
        var c = byte_at(text, i)
        if c == ord("\n") and (i + 1 >= text.byte_length() or byte_at(text, i + 1) == ord("\n")):
            if block.byte_length() > 0:
                var let = chr(ord("A") + letter_i)
                pieces.append(parse_piece(block, let))
                letter_i += 1
                block = String()
            i += 1
        else:
            block += chr(c)
        i += 1
    if block.byte_length() > 0:
        var let2 = chr(ord("A") + letter_i)
        pieces.append(parse_piece(block, let2))
    if len(pieces) == 0:
        raise Error("no pieces")
    return pieces^

struct Board(Movable):
    var size: Int
    var cells: List[String]

    def __init__(out self, size: Int):
        self.size = size
        self.cells = List[String]()
        var y = 0
        while y < size:
            var row = String()
            var x = 0
            while x < size:
                row += "."
                x += 1
            self.cells.append(row^)
            y += 1

    def can_place(self, t: Tetromino, ox: Int, oy: Int) -> Bool:
        var i = 0
        while i < 4:
            var x = ox + t.cells[i].x
            var y = oy + t.cells[i].y
            if x < 0 or y < 0 or x >= self.size or y >= self.size:
                return False
            if byte_at(self.cells[y], x) != ord("."):
                return False
            i += 1
        return True

    def place(mut self, t: Tetromino, ox: Int, oy: Int, ch: String):
        var i = 0
        while i < 4:
            var x = ox + t.cells[i].x
            var y = oy + t.cells[i].y
            var row = String()
            var c = 0
            while c < self.size:
                if c == x:
                    row += ch
                else:
                    row += chr(byte_at(self.cells[y], c))
                c += 1
            self.cells[y] = row^
            i += 1

    def render(self) -> String:
        var out = String()
        var y = 0
        while y < self.size:
            out += self.cells[y]
            out += "\n"
            y += 1
        return out^

def solve_rec(mut board: Board, pieces: List[Tetromino], idx: Int) -> Bool:
    if idx >= len(pieces):
        return True
    var y = 0
    while y < board.size:
        var x = 0
        while x < board.size:
            if board.can_place(pieces[idx], x, y):
                board.place(pieces[idx], x, y, pieces[idx].letter)
                if solve_rec(board, pieces, idx + 1):
                    return True
                board.place(pieces[idx], x, y, ".")
            x += 1
        y += 1
    return False

def ceil_sqrt(n: Int) -> Int:
    var s = 1
    while s * s < n:
        s += 1
    return s

def solve_fillit(path: String) raises -> String:
    var pieces = parse_file(path)
    var size = ceil_sqrt(len(pieces) * 4)
    while size <= 16:
        var board = Board(size)
        if solve_rec(board, pieces, 0):
            return board.render()
        size += 1
    raise Error("no solution")
