"""ft_printf — small formatted printer (subset of printf conversions)."""

from libft.string import byte_at, ft_itoa, ft_itoa_base
from libft.ctype import ft_toupper

struct FormatArgs(Movable):
    """Simple positional arg bag for demo/testing."""
    var ints: List[Int]
    var uints: List[UInt64]
    var strings: List[String]
    var i_int: Int
    var i_uint: Int
    var i_str: Int

    def __init__(out self):
        self.ints = List[Int]()
        self.uints = List[UInt64]()
        self.strings = List[String]()
        self.i_int = 0
        self.i_uint = 0
        self.i_str = 0

    def add_int(mut self, v: Int):
        self.ints.append(v)

    def add_uint(mut self, v: UInt64):
        self.uints.append(v)

    def add_str(mut self, v: String):
        self.strings.append(v)

    def next_int(mut self) raises -> Int:
        if self.i_int >= len(self.ints):
            raise Error("missing int arg")
        var v = self.ints[self.i_int]
        self.i_int += 1
        return v

    def next_uint(mut self) raises -> UInt64:
        if self.i_uint >= len(self.uints):
            raise Error("missing uint arg")
        var v = self.uints[self.i_uint]
        self.i_uint += 1
        return v

    def next_str(mut self) raises -> String:
        if self.i_str >= len(self.strings):
            raise Error("missing str arg")
        var v = self.strings[self.i_str]
        self.i_str += 1
        return v

def _upper_hex(s: String) -> String:
    var out = String()
    var i = 0
    while i < s.byte_length():
        out += chr(ft_toupper(byte_at(s, i)))
        i += 1
    return out^

def ft_printf(fmt: String, mut args: FormatArgs) raises -> Int:
    """Format `fmt` using args. Supports %% %d %i %s %c %u %x %X %o."""
    var out = String()
    var i = 0
    var n = fmt.byte_length()
    while i < n:
        var c = byte_at(fmt, i)
        if c != ord("%"):
            out += chr(c)
            i += 1
            continue
        i += 1
        if i >= n:
            break
        var spec = byte_at(fmt, i)
        if spec == ord("%"):
            out += "%"
        elif spec == ord("d") or spec == ord("i"):
            out += ft_itoa(args.next_int())
        elif spec == ord("u"):
            out += ft_itoa_base(args.next_uint(), 10)
        elif spec == ord("x"):
            out += ft_itoa_base(args.next_uint(), 16)
        elif spec == ord("X"):
            out += _upper_hex(ft_itoa_base(args.next_uint(), 16))
        elif spec == ord("o"):
            out += ft_itoa_base(args.next_uint(), 8)
        elif spec == ord("s"):
            out += args.next_str()
        elif spec == ord("c"):
            out += chr(args.next_int())
        else:
            out += "%"
            out += chr(spec)
        i += 1
    print(out, end="")
    return out.byte_length()

def ft_sprintf(fmt: String, mut args: FormatArgs) raises -> String:
    var out = String()
    var i = 0
    var n = fmt.byte_length()
    while i < n:
        var c = byte_at(fmt, i)
        if c != ord("%"):
            out += chr(c)
            i += 1
            continue
        i += 1
        if i >= n:
            break
        var spec = byte_at(fmt, i)
        if spec == ord("%"):
            out += "%"
        elif spec == ord("d") or spec == ord("i"):
            out += ft_itoa(args.next_int())
        elif spec == ord("u"):
            out += ft_itoa_base(args.next_uint(), 10)
        elif spec == ord("x"):
            out += ft_itoa_base(args.next_uint(), 16)
        elif spec == ord("X"):
            out += _upper_hex(ft_itoa_base(args.next_uint(), 16))
        elif spec == ord("o"):
            out += ft_itoa_base(args.next_uint(), 8)
        elif spec == ord("s"):
            out += args.next_str()
        elif spec == ord("c"):
            out += chr(args.next_int())
        else:
            out += "%"
            out += chr(spec)
        i += 1
    return out^
