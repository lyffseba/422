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

def ft_substr(s: String, start: Int, length: Int) -> String:
    var out = String()
    if start < 0 or start >= s.byte_length() or length <= 0:
        return out^
    var i = start
    var end = start + length
    if end > s.byte_length():
        end = s.byte_length()
    while i < end:
        out += chr(byte_at(s, i))
        i += 1
    return out^

def ft_strchr(s: String, c: Int) -> Int:
    """Return byte index of c or -1."""
    var i = 0
    while i < s.byte_length():
        if byte_at(s, i) == c:
            return i
        i += 1
    return -1

def ft_strstr(hay: String, needle: String) -> Int:
    """Return start index of needle in hay or -1."""
    var nlen = needle.byte_length()
    if nlen == 0:
        return 0
    var i = 0
    while i + nlen <= hay.byte_length():
        var j = 0
        var ok = True
        while j < nlen:
            if byte_at(hay, i + j) != byte_at(needle, j):
                ok = False
                break
            j += 1
        if ok:
            return i
        i += 1
    return -1

def starts_with(s: String, prefix: String) -> Bool:
    if prefix.byte_length() > s.byte_length():
        return False
    return ft_strnequ(s, prefix, prefix.byte_length())

def strip_newline(s: String) -> String:
    var n = s.byte_length()
    while n > 0 and (byte_at(s, n - 1) == ord("\n") or byte_at(s, n - 1) == ord("\r")):
        n -= 1
    return ft_substr(s, 0, n)

def ft_strtrim(s: String) -> String:
    var a = 0
    var b = s.byte_length()
    while a < b and ft_iswhitespace(byte_at(s, a)):
        a += 1
    while b > a and ft_iswhitespace(byte_at(s, b - 1)):
        b -= 1
    return ft_substr(s, a, b - a)
