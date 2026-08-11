"""Character classification — Mojo analogue of libc ctype + libft extras."""

def ft_isdigit(c: Int) -> Bool:
    return c >= ord("0") and c <= ord("9")

def ft_isalpha(c: Int) -> Bool:
    return (c >= ord("a") and c <= ord("z")) or (c >= ord("A") and c <= ord("Z"))

def ft_isalnum(c: Int) -> Bool:
    return ft_isalpha(c) or ft_isdigit(c)

def ft_isascii(c: Int) -> Bool:
    return c >= 0 and c <= 127

def ft_isprint(c: Int) -> Bool:
    return c >= 32 and c <= 126

def ft_iswhitespace(c: Int) -> Bool:
    return c == ord(" ") or c == ord("\t") or c == ord("\n") or c == ord("\r") or c == ord("\v") or c == ord("\f")

def ft_tolower(c: Int) -> Int:
    if c >= ord("A") and c <= ord("Z"):
        return c + 32
    return c

def ft_toupper(c: Int) -> Int:
    if c >= ord("a") and c <= ord("z"):
        return c - 32
    return c
