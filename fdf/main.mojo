from std.sys.arg import argv
from std.testing import assert_true, TestSuite
from fdf.render import render_file

def test_fdf() raises:
    var out = render_file("fdf/resources/maps/42.fdf")
    assert_true(out.byte_length() > 0)

def main() raises:
    var args = argv()
    var path = String("fdf/resources/maps/42.fdf")
    if len(args) >= 2:
        path = args[1]
    print(render_file(path), end="")
    if len(args) < 2:
        TestSuite.discover_tests[__functions_in_module()]().run()
