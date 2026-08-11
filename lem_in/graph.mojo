"""Lem-in — anthill graph BFS pathfinding and ant dispatch."""

from std.pathlib import Path
from libft.string import byte_at, ft_atoi, ft_itoa, ft_split, starts_with

@fieldwise_init
struct Room(Copyable, Movable):
    var name: String
    var x: Int
    var y: Int

struct Anthill(Movable):
    var ants: Int
    var rooms: List[Room]
    var edges: List[List[Int]]  # adjacency by room index
    var start: Int
    var end: Int
    var name_index: List[String]  # parallel names for lookup

    def __init__(out self):
        self.ants = 0
        self.rooms = List[Room]()
        self.edges = List[List[Int]]()
        self.start = -1
        self.end = -1
        self.name_index = List[String]()

    def find_room(self, name: String) -> Int:
        var i = 0
        while i < len(self.name_index):
            if self.name_index[i] == name:
                return i
            i += 1
        return -1

    def add_room(mut self, name: String, x: Int, y: Int) raises:
        if self.find_room(name) >= 0:
            raise Error("dup room")
        self.rooms.append(Room(name, x, y))
        self.name_index.append(name)
        self.edges.append(List[Int]())

    def add_edge(mut self, a: String, b: String) raises:
        var ia = self.find_room(a)
        var ib = self.find_room(b)
        if ia < 0 or ib < 0:
            raise Error("bad link")
        self.edges[ia].append(ib)
        self.edges[ib].append(ia)

def parse_map(text: String) raises -> Anthill:
    var hill = Anthill()
    var lines = List[String]()
    var cur = String()
    var i = 0
    while i < text.byte_length():
        var c = byte_at(text, i)
        if c == ord("\n"):
            lines.append(cur)
            cur = String()
        else:
            cur += chr(c)
        i += 1
    if cur.byte_length() > 0:
        lines.append(cur)
    if len(lines) == 0:
        raise Error("empty")
    hill.ants = ft_atoi(lines[0])
    if hill.ants <= 0:
        raise Error("bad ants")
    var next_start = False
    var next_end = False
    i = 1
    while i < len(lines):
        var line = lines[i]
        if line.byte_length() == 0:
            i += 1
            continue
        if byte_at(line, 0) == ord("#"):
            if line == "##start":
                next_start = True
            elif line == "##end":
                next_end = True
            i += 1
            continue
        # link or room
        var has_dash = False
        var di = 0
        while di < line.byte_length():
            if byte_at(line, di) == ord("-"):
                has_dash = True
                break
            di += 1
        if has_dash and byte_at(line, 0) != ord("L"):
            # link name-name
            var left = String()
            var right = String()
            var side = 0
            var k = 0
            while k < line.byte_length():
                var ch = byte_at(line, k)
                if ch == ord("-") and side == 0:
                    side = 1
                elif side == 0:
                    left += chr(ch)
                else:
                    right += chr(ch)
                k += 1
            hill.add_edge(left, right)
        else:
            var parts = ft_split(line, ord(" "))
            if len(parts) < 3:
                raise Error("bad room")
            hill.add_room(parts[0], ft_atoi(parts[1]), ft_atoi(parts[2]))
            if next_start:
                hill.start = hill.find_room(parts[0])
                next_start = False
            if next_end:
                hill.end = hill.find_room(parts[0])
                next_end = False
        i += 1
    if hill.start < 0 or hill.end < 0:
        raise Error("need start/end")
    return hill^

def bfs_path(hill: Anthill) -> List[Int]:
    """Return room indices start→end, or empty if none."""
    var n = len(hill.rooms)
    var prev = List[Int]()
    var seen = List[Int]()
    var q = List[Int]()
    var i = 0
    while i < n:
        prev.append(-1)
        seen.append(0)
        i += 1
    q.append(hill.start)
    seen[hill.start] = 1
    var qi = 0
    while qi < len(q):
        var u = q[qi]
        qi += 1
        if u == hill.end:
            break
        var e = 0
        while e < len(hill.edges[u]):
            var v = hill.edges[u][e]
            if seen[v] == 0:
                seen[v] = 1
                prev[v] = u
                q.append(v)
            e += 1
    if seen[hill.end] == 0:
        return List[Int]()
    # reconstruct
    var path_rev = List[Int]()
    var cur = hill.end
    while cur != -1:
        path_rev.append(cur)
        cur = prev[cur]
    var path = List[Int]()
    i = len(path_rev) - 1
    while i >= 0:
        path.append(path_rev[i])
        i -= 1
    return path^

def solve_lemin(text: String) raises -> String:
    var hill = parse_map(text)
    var path = bfs_path(hill)
    if len(path) == 0:
        raise Error("no path")
    var out = String()
    # echo input first (subject style simplified: just moves)
    var ant = 1
    while ant <= hill.ants:
        # each ant walks path[1..]
        var step = 1
        while step < len(path):
            out += "L"
            out += ft_itoa(ant)
            out += "-"
            out += hill.rooms[path[step]].name
            if step < len(path) - 1 or ant < hill.ants:
                out += " "
            step += 1
        out += "\n"
        ant += 1
    return out^
