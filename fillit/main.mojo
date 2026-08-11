from std.sys.arg import argv
from std.testing import assert_true, TestSuite
from fillit.solver import solve_fillit

def test_simple() raises:
    var out = solve_fillit("fillit/resources/valid_files/test1")
    assert_true(out.byte_length() > 0)
    assert_true(String(out).byte_length() >= 4)

def main() raises:
    var args = argv()
    if len(args) >= 2:
        print(solve_fillit(args[1]), end="")
        return
    TestSuite.discover_tests[__functions_in_module()]().run()
