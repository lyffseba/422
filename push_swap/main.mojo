from std.sys.arg import argv
from std.testing import assert_true, assert_equal, TestSuite
from push_swap.stack import Piles, sort_small, parse_int_list, ops_to_string

def test_sort_three() raises:
    var vals: List[Int] = [3, 2, 1]
    var p = Piles(vals)
    sort_small(p)
    assert_true(p.is_sorted())
    assert_equal(len(p.b), 0)

def test_sort_five() raises:
    var vals: List[Int] = [5, 1, 4, 2, 3]
    var p = Piles(vals)
    sort_small(p)
    assert_true(p.is_sorted())

def test_already_sorted() raises:
    var vals: List[Int] = [1, 2, 3]
    var p = Piles(vals)
    sort_small(p)
    assert_true(p.is_sorted())
    assert_equal(len(p.ops), 0)

def test_checker_sa() raises:
    var vals: List[Int] = [2, 1]
    var p = Piles(vals)
    p.record = False
    p.apply("sa")
    assert_true(p.is_sorted())

def main() raises:
    var args = argv()
    if len(args) >= 2:
        try:
            var tokens = List[String]()
            var i = 1
            while i < len(args):
                tokens.append(String(args[i]))
                i += 1
            var vals = parse_int_list(tokens)
            var p = Piles(vals)
            sort_small(p)
            print(ops_to_string(p.ops), end="")
        except e:
            print("Error")
        return
    TestSuite.discover_tests[__functions_in_module()]().run()
