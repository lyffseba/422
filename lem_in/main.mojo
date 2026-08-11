from std.sys.arg import argv
from std.pathlib import Path
from std.io.file import open
from std.testing import assert_true, TestSuite
from lem_in.graph import solve_lemin

def test_lemin() raises:
    var m = "2\n##start\nstart 0 0\nmid 1 0\n##end\nend 2 0\nstart-mid\nmid-end\n"
    var out = solve_lemin(m)
    assert_true(out.byte_length() > 0)

def main() raises:
    var args = argv()
    if len(args) >= 2:
        var text = Path(args[1]).read_text()
        print(solve_lemin(text), end="")
        return
    TestSuite.discover_tests[__functions_in_module()]().run()
