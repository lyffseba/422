from std.sys.arg import argv
from std.pathlib import Path
from std.testing import assert_true, TestSuite
from lem_in.graph import solve_lemin
from libft.string import byte_at

def test_lemin() raises:
    var m = "2\n##start\nstart 0 0\nmid 1 0\n##end\nend 2 0\nstart-mid\nmid-end\n"
    var out = solve_lemin(m)
    assert_true(out.byte_length() > 0)

def test_lemin_has_turns() raises:
    var text = Path("lem_in/resources/valid_maps/simple").read_text()
    var out = solve_lemin(text)
    var lines = 0
    var i = 0
    while i < out.byte_length():
        if byte_at(out, i) == ord("\n"):
            lines += 1
        i += 1
    assert_true(lines > 5)

def main() raises:
    var args = argv()
    if len(args) >= 2:
        try:
            var text = Path(args[1]).read_text()
            print(solve_lemin(text), end="")
        except e:
            print("Error")
        return
    TestSuite.discover_tests[__functions_in_module()]().run()
