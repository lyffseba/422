"""Output helpers (stdout writers)."""

from .string import ft_itoa

def ft_putchar(c: Int):
    print(chr(c), end="")

def ft_putstr(s: String):
    print(s, end="")

def ft_putendl(s: String):
    print(s)

def ft_putnbr(n: Int):
    print(ft_itoa(n), end="")
