"""Day 01 — string / dict round-trip through PythonObject."""

from std.python import Python

def main() raises:
    var builtins = Python.import_module("builtins")
    var d = Python.dict()
    d["lang"] = "mojo"
    d["twin"] = "421"
    print(d)
    print("keys:", builtins.list(d.keys()))
