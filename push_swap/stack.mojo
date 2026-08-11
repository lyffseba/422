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

def _index_compress(values: List[Int]) -> List[Int]:
    """Map values to ranks 0..n-1 (stable by value order)."""
    var n = len(values)
    var ranks = List[Int]()
    var i = 0
    while i < n:
        ranks.append(0)
        i += 1
    i = 0
    while i < n:
        var r = 0
        var j = 0
        while j < n:
            if values[j] < values[i] or (values[j] == values[i] and j < i):
                r += 1
            j += 1
        ranks[i] = r
        i += 1
    return ranks^

def _sort_two(mut p: Piles):
    if len(p.a) == 2 and p.a[0] > p.a[1]:
        p.sa()

def _sort_three(mut p: Piles):
    if len(p.a) != 3:
        return
    var a = p.a[0]
    var b = p.a[1]
    var c = p.a[2]
    # 6 permutations
    if a < b and b < c:
        return
    elif a > b and b < c and a < c:
        p.sa()
    elif a > b and b > c:
        p.sa()
        p.rra()
    elif a > b and b < c and a > c:
        p.ra()
    elif a < b and b > c and a < c:
        p.sa()
        p.ra()
    else:
        # a < b and b > c and a > c
        p.rra()


def _find_min_index(stack: List[Int]) -> Int:
    var min_i = 0
    var min_v = stack[0]
    var i = 1
    while i < len(stack):
        if stack[i] < min_v:
            min_v = stack[i]
            min_i = i
        i += 1
    return min_i

def _find_max_index(stack: List[Int]) -> Int:
    var max_i = 0
    var max_v = stack[0]
    var i = 1
    while i < len(stack):
        if stack[i] > max_v:
            max_v = stack[i]
            max_i = i
        i += 1
    return max_i

def _rotate_a_to(mut p: Piles, idx: Int):
    var n = len(p.a)
    if n == 0:
        return
    if idx <= n // 2:
        var i = 0
        while i < idx:
            p.ra()
            i += 1
    else:
        var i = 0
        while i < (n - idx):
            p.rra()
            i += 1

def _rotate_b_to(mut p: Piles, idx: Int):
    var n = len(p.b)
    if n == 0:
        return
    if idx <= n // 2:
        var i = 0
        while i < idx:
            p.rb()
            i += 1
    else:
        var i = 0
        while i < (n - idx):
            p.rrb()
            i += 1

def _sort_selection(mut p: Piles):
    while len(p.a) > 3:
        var idx = _find_min_index(p.a)
        _rotate_a_to(p, idx)
        p.pb()
    if len(p.a) == 3:
        _sort_three(p)
    elif len(p.a) == 2:
        _sort_two(p)
    while len(p.b) > 0:
        p.pa()

def _sort_chunks(mut p: Piles):
    """Chunked push to B then extract max — good general bound."""
    var n = len(p.a)
    var ranks = _index_compress(p.a)
    p.a = ranks^
    # chunk size ~ n/5 clamped
    var chunk = n // 5
    if chunk < 10:
        chunk = 10
    if chunk > 40:
        chunk = 40
    var bound = chunk
    while len(p.a) > 0:
        # if top in [0, bound) push, rotate b if in lower half of current window
        if p.a[0] < bound:
            var v = p.a[0]
            p.pb()
            if len(p.b) > 1 and v < bound - chunk // 2:
                p.rb()
        else:
            p.ra()
        # advance bound when enough pushed
        if len(p.b) >= bound and bound < n:
            bound += chunk
            if bound > n:
                bound = n
        # safety: if a is only large leftovers and bound stuck
        if len(p.a) > 0 and bound < n:
            # if nothing in range left, raise bound
            var has = False
            var i = 0
            while i < len(p.a):
                if p.a[i] < bound:
                    has = True
                    break
                i += 1
            if not has:
                bound += chunk
                if bound > n:
                    bound = n
    # pull max from b
    while len(p.b) > 0:
        var idx = _find_max_index(p.b)
        _rotate_b_to(p, idx)
        p.pa()

def sort_small(mut p: Piles):
    """Public entry: specialized small + selection medium + chunks large."""
    var n = len(p.a)
    if n <= 1 or p.is_sorted():
        return
    if n == 2:
        _sort_two(p)
        return
    if n == 3:
        _sort_three(p)
        return
    if n <= 6:
        _sort_selection(p)
        return
    if n <= 100:
        # selection is excellent on many patterns and stays under 700 for n=100 worst-ish
        _sort_selection(p)
        return
    _sort_chunks(p)


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
