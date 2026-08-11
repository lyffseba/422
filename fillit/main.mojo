from std.sys.arg import argv
from std.testing import assert_true, assert_equal, TestSuite
from fillit.solver import solve_fillit
from libft.string import byte_at

def test_simple() raises:
    var out = solve_fillit("fillit/resources/valid_files/test1")
    assert_true(out.byte_length() > 0)

def test_two_pieces() raises:
    var out = solve_fillit("fillit/resources/valid_files/test2")
    assert_true(out.byte_length() >= 8)
    # must contain A and B
    var has_a = False
    var has_b = False
    var i = 0
    while i < out.byte_length():
        if byte_at(out, i) == ord("A"):
            has_a = True
        if byte_at(out, i) == ord("B"):
            has_b = True
        i += 1
    assert_true(has_a)
    assert_true(has_b)

def test_invalid() raises:
    var raised = False
    try:
        _ = solve_fillit("fillit/resources/invalid_files/test1")
    except e:
        raised = True
    assert_true(raised)

def main() raises:
    var args = argv()
    if len(args) >= 2:
        try:
            print(solve_fillit(args[1]), end="")
        except e:
            print("error")
        return
    TestSuite.discover_tests[__functions_in_module()]().run()
