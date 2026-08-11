"""Line-oriented reader with an internal buffer (GNL semantics)."""

from std.pathlib import Path
from libft.string import byte_at

struct GetNextLine(Movable):
    var data: String
    var pos: Int
    var eof: Bool

    def __init__(out self, var text: String):
        self.data = text^
        self.pos = 0
        self.eof = False

    @staticmethod
    def from_path(path: String) raises -> GetNextLine:
        var text = Path(path).read_text()
        return GetNextLine(text^)

    def next_line(mut self) -> Optional[String]:
        if self.eof:
            return None
        if self.pos >= self.data.byte_length():
            self.eof = True
            return None
        var start = self.pos
        var n = self.data.byte_length()
        while self.pos < n and byte_at(self.data, self.pos) != ord("\n"):
            self.pos += 1
        var out = String()
        var i = start
        while i < self.pos:
            out += chr(byte_at(self.data, i))
            i += 1
        if self.pos < n and byte_at(self.data, self.pos) == ord("\n"):
            self.pos += 1
        if self.pos >= n:
            self.eof = True
        return Optional[String](out^)

def read_lines(path: String) raises -> List[String]:
    var gnl = GetNextLine.from_path(path)
    var lines = List[String]()
    while True:
        var line = gnl.next_line()
        if not line:
            break
        lines.append(line.value().copy())
    return lines^
