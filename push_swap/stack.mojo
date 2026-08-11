"""Two-stack machine for push_swap (421-equivalent instruction set)."""

from libft.string import ft_atoi, byte_at

struct Piles(Movable):
    var a: List[Int]
    var b: List[Int]
    var ops: List[String]
    var record: Bool

    def __init__(out self, values: List[Int]):
        self.a = List[Int]()
        var i = 0
        while i < len(values):
            self.a.append(values[i])
            i += 1
        self.b = List[Int]()
        self.ops = List[String]()
        self.record = True

    def _log(mut self, op: String):
        if self.record:
            self.ops.append(op)

    def sa(mut self):
        if len(self.a) >= 2:
            var t = self.a[0]
            self.a[0] = self.a[1]
            self.a[1] = t
        self._log("sa")

    def sb(mut self):
        if len(self.b) >= 2:
            var t = self.b[0]
            self.b[0] = self.b[1]
            self.b[1] = t
        self._log("sb")

    def ss(mut self):
        var r = self.record
        self.record = False
        self.sa()
        self.sb()
        self.record = r
        self._log("ss")

    def pa(mut self):
        if len(self.b) > 0:
            var v = self.b[0]
            var nb = List[Int]()
            var i = 1
            while i < len(self.b):
                nb.append(self.b[i])
                i += 1
            self.b = nb^
            var na = List[Int]()
            na.append(v)
            i = 0
            while i < len(self.a):
                na.append(self.a[i])
                i += 1
            self.a = na^
        self._log("pa")

    def pb(mut self):
        if len(self.a) > 0:
            var v = self.a[0]
            var na = List[Int]()
            var i = 1
            while i < len(self.a):
                na.append(self.a[i])
                i += 1
            self.a = na^
            var nb = List[Int]()
            nb.append(v)
            i = 0
            while i < len(self.b):
                nb.append(self.b[i])
                i += 1
            self.b = nb^
        self._log("pb")

    def ra(mut self):
        if len(self.a) >= 2:
            var v = self.a[0]
            var na = List[Int]()
            var i = 1
            while i < len(self.a):
                na.append(self.a[i])
                i += 1
            na.append(v)
            self.a = na^
        self._log("ra")

    def rb(mut self):
        if len(self.b) >= 2:
            var v = self.b[0]
            var nb = List[Int]()
            var i = 1
            while i < len(self.b):
                nb.append(self.b[i])
                i += 1
            nb.append(v)
            self.b = nb^
        self._log("rb")

    def rr(mut self):
        var r = self.record
        self.record = False
        self.ra()
        self.rb()
        self.record = r
        self._log("rr")

    def rra(mut self):
        if len(self.a) >= 2:
            var last = self.a[len(self.a) - 1]
            var na = List[Int]()
            na.append(last)
            var i = 0
            while i < len(self.a) - 1:
                na.append(self.a[i])
                i += 1
            self.a = na^
        self._log("rra")

    def rrb(mut self):
        if len(self.b) >= 2:
            var last = self.b[len(self.b) - 1]
            var nb = List[Int]()
            nb.append(last)
            var i = 0
            while i < len(self.b) - 1:
                nb.append(self.b[i])
                i += 1
            self.b = nb^
        self._log("rrb")

    def rrr(mut self):
        var r = self.record
        self.record = False
        self.rra()
        self.rrb()
        self.record = r
        self._log("rrr")

    def is_sorted(self) -> Bool:
        if len(self.b) != 0:
            return False
        if len(self.a) <= 1:
            return True
        var i = 0
        while i < len(self.a) - 1:
            if self.a[i] > self.a[i + 1]:
                return False
            i += 1
        return True

    def apply(mut self, instr: String) raises:
        if instr == "sa":
            self.sa()
        elif instr == "sb":
            self.sb()
        elif instr == "ss":
            self.ss()
        elif instr == "pa":
            self.pa()
        elif instr == "pb":
            self.pb()
        elif instr == "ra":
            self.ra()
        elif instr == "rb":
            self.rb()
        elif instr == "rr":
            self.rr()
        elif instr == "rra":
            self.rra()
        elif instr == "rrb":
            self.rrb()
        elif instr == "rrr":
            self.rrr()
        else:
            raise Error("Error")

def sort_small(mut p: Piles):
    """Correct selection sort via pb/pa/rotate. Always sorts; not ops-optimal."""
    if p.is_sorted():
        return
    if len(p.a) == 2:
        if p.a[0] > p.a[1]:
            p.sa()
        return
    while len(p.a) > 0:
        var min_i = 0
        var min_v = p.a[0]
        var i = 1
        while i < len(p.a):
            if p.a[i] < min_v:
                min_v = p.a[i]
                min_i = i
            i += 1
        if min_i <= len(p.a) // 2:
            var r = 0
            while r < min_i:
                p.ra()
                r += 1
        else:
            var rr = 0
            while rr < (len(p.a) - min_i):
                p.rra()
                rr += 1
        p.pb()
    while len(p.b) > 0:
        p.pa()

def parse_int_token(s: String) raises -> Int:
    if s.byte_length() == 0:
        raise Error("Error")
    var j = 0
    if j < s.byte_length() and (byte_at(s, j) == ord("-") or byte_at(s, j) == ord("+")):
        j += 1
    if j >= s.byte_length():
        raise Error("Error")
    while j < s.byte_length():
        var c = byte_at(s, j)
        if c < ord("0") or c > ord("9"):
            raise Error("Error")
        j += 1
    return ft_atoi(s)

def parse_int_list(tokens: List[String]) raises -> List[Int]:
    var vals = List[Int]()
    var i = 0
    while i < len(tokens):
        var v = parse_int_token(tokens[i])
        var k = 0
        while k < len(vals):
            if vals[k] == v:
                raise Error("Error")
            k += 1
        vals.append(v)
        i += 1
    return vals^

def ops_to_string(ops: List[String]) -> String:
    var out = String()
    var i = 0
    while i < len(ops):
        out += ops[i]
        out += "\n"
        i += 1
    return out^
