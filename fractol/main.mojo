from std.sys.arg import argv
from std.testing import assert_true, TestSuite
from fractol.fractal import render_mandelbrot, render_julia

def test_fractal() raises:
    var m = render_mandelbrot(40, 12, 25)
    assert_true(m.byte_length() > 40)

def main() raises:
    var args = argv()
    var kind = String("mandelbrot")
    if len(args) >= 2:
        kind = args[1]
    if kind == "julia":
        print(render_julia(), end="")
    else:
        print(render_mandelbrot(), end="")
    if len(args) < 2:
        TestSuite.discover_tests[__functions_in_module()]().run()
