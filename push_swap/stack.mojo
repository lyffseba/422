"""Two-stack machine for push_swap."""

from libft.string import ft_itoa

struct Piles(Movable):
    var a: List[Int]
    var b: List[Int]
    var ops: List[String]

    def __init__(out self, values: List[Int]):
        self.a = List[Int]()
        var i = 0
        while i < len(values):
            self.a.append(values[i])
            i += 1
        self.b = List[Int]()
        self.ops = List[String]()

    def _record(mut self, op: String):
        self.ops.append(op)

    def sa(mut self):
        if len(self.a) >= 2:
            var t = self.a[0]
            self.a[0] = self.a[1]
            self.a[1] = t
        self._record("sa")

    def sb(mut self):
        if len(self.b) >= 2:
            var t = self.b[0]
            self.b[0] = self.b[1]
            self.b[1] = t
        self._record("sb")

    def ss(mut self):
        # do without double-recording
        if len(self.a) >= 2:
            var t = self.a[0]
            self.a[0] = self.a[1]
            self.a[1] = t
        if len(self.b) >= 2:
            var t2 = self.b[0]
            self.b[0] = self.b[1]
            self.b[1] = t2
        self._record("ss")

    def pa(mut self):
        if len(self.b) > 0:
            var v = self.b[0]
            # pop front b
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
        self._record("pa")

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
        self._record("pb")

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
        self._record("ra")

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
        self._record("rb")

    def rr(mut self):
        if len(self.a) >= 2:
            var v = self.a[0]
            var na = List[Int]()
            var i = 1
            while i < len(self.a):
                na.append(self.a[i])
                i += 1
            na.append(v)
            self.a = na^
        if len(self.b) >= 2:
            var v2 = self.b[0]
            var nb = List[Int]()
            var j = 1
            while j < len(self.b):
                nb.append(self.b[j])
                j += 1
            nb.append(v2)
            self.b = nb^
        self._record("rr")

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
        self._record("rra")

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
        self._record("rrb")

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
            # reverse both
            if len(self.a) >= 2:
                var last = self.a[len(self.a) - 1]
                var na = List[Int]()
                na.append(last)
                var i = 0
                while i < len(self.a) - 1:
                    na.append(self.a[i])
                    i += 1
                self.a = na^
            if len(self.b) >= 2:
                var lastb = self.b[len(self.b) - 1]
                var nb = List[Int]()
                nb.append(lastb)
                var j = 0
                while j < len(self.b) - 1:
                    nb.append(self.b[j])
                    j += 1
                self.b = nb^
            self._record("rrr")
        else:
            raise Error("bad instruction")

def sort_small(mut p: Piles):
    """Simple O(n^2) selection-style sort using pb/pa/ra — correct, not optimal."""
    if p.is_sorted():
        return
    # sort 2
    if len(p.a) == 2:
        if p.a[0] > p.a[1]:
            p.sa()
        return
    # general: push min to b until a empty, then pa all
    while len(p.a) > 0:
        # find min index
        var min_i = 0
        var min_v = p.a[0]
        var i = 1
        while i < len(p.a):
            if p.a[i] < min_v:
                min_v = p.a[i]
                min_i = i
            i += 1
        # rotate min to top
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

def parse_args(args: List[String]) raises -> List[Int]:
    var vals = List[Int]()
    var i = 1  # skip argv0
    while i < len(args):
        var v = ft_atoi(args[i])
        # reject non-numeric lightly
        if args[i].byte_length() == 0:
            raise Error("Error")
        # uniqueness
        var j = 0
        while j < len(vals):
            if vals[j] == v:
                raise Error("Error")
            j += 1
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
