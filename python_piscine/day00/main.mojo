"""Day 00 — call CPython from Mojo (maps to 421 php_piscine day0 spirit)."""

from std.python import Python

def main() raises:
    print("python_piscine day00")
    var math = Python.import_module("math")
    var builtins = Python.import_module("builtins")
    var root = math.sqrt(16)
    print("math.sqrt(16) =", root)
    var nums = Python.list(1, 2, 3, 4)
    print("sum via Python =", builtins.sum(nums))
