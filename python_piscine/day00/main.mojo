"""Day 00: Python interop hello (graceful if Python bridge unavailable)."""

def main():
    print("python_piscine day00")
    try:
        from python import Python
        var py = Python.import_module("math")
        var v = py.sqrt(16)
        print("math.sqrt(16) via Python =", v)
    except e:
        print("Python interop not available in this environment:")
        print(e)
        print("Mojo-native fallback:", 4)
