"""String helpers rebuilt the 42 way (no std sugar where it matters)."""

from .ctype import ft_isdigit, ft_iswhitespace

def byte_at(s: String, i: Int) -> Int:
    return Int(s.unsafe_ptr().load(i))

def ft_strlen(s: String) -> Int:
    return s.byte_length()

def ft_strcmp(a: String, b: String) -> Int:
    var i = 0
    var na = a.byte_length()
    var nb = b.byte_length()
    while i < na and i < nb:
        var ca = byte_at(a, i)
        var cb = byte_at(b, i)
        if ca != cb:
            return ca - cb
        i += 1
    return na - nb

def ft_strequ(a: String, b: String) -> Bool:
    return ft_strcmp(a, b) == 0

def ft_strnequ(a: String, b: String, n: Int) -> Bool:
    var i = 0
    while i < n:
        if i >= a.byte_length() and i >= b.byte_length():
            return True
        if i >= a.byte_length() or i >= b.byte_length():
            return False
        if byte_at(a, i) != byte_at(b, i):
            return False
        i += 1
    return True

def ft_strdup(s: String) -> String:
    return String(s)

def ft_strjoin(a: String, b: String) -> String:
    return a + b

def ft_strncpy(src: String, n: Int) -> String:
    var out = String()
    var i = 0
    var lim = n
    if lim > src.byte_length():
        lim = src.byte_length()
    while i < lim:
        out += chr(byte_at(src, i))
        i += 1
    return out^

def ft_atoi(s: String) -> Int:
    var n = 0
    var i = 0
    var sign = 1
    var nlen = s.byte_length()
    while i < nlen and ft_iswhitespace(byte_at(s, i)):
        i += 1
    if i < nlen and byte_at(s, i) == ord("-"):
        sign = -1
        i += 1
    elif i < nlen and byte_at(s, i) == ord("+"):
        i += 1
    while i < nlen and ft_isdigit(byte_at(s, i)):
        n = n * 10 + (byte_at(s, i) - ord("0"))
        i += 1
    return n * sign

def ft_itoa(n: Int) -> String:
    if n == 0:
        return String("0")
    var neg = n < 0
    var v = n
    if neg:
        v = -v
    var digits = List[Int]()
    while v > 0:
        digits.append(v % 10)
        v = v // 10
    var out = String()
    if neg:
        out += "-"
    var i = len(digits) - 1
    while i >= 0:
        out += chr(digits[i] + ord("0"))
        i -= 1
    return out^

def ft_itoa_base(n: UInt64, base: Int) -> String:
    if base < 2 or base > 16:
        return String("")
    if n == 0:
        return String("0")
    var digits_chars = "0123456789abcdef"
    var v = n
    var digits = List[Int]()
    var b = UInt64(base)
    while v > 0:
        digits.append(Int(v % b))
        v = v // b
    var out = String()
    var i = len(digits) - 1
    while i >= 0:
        out += String(digits_chars[byte=digits[i]])
        i -= 1
    return out^

def ft_split(s: String, sep: Int) -> List[String]:
    var out = List[String]()
    var cur = String()
    var i = 0
    while i < s.byte_length():
        var c = byte_at(s, i)
        if c == sep:
            if cur.byte_length() > 0:
                out.append(cur)
                cur = String()
        else:
            cur += chr(c)
        i += 1
    if cur.byte_length() > 0:
        out.append(cur)
    return out^
