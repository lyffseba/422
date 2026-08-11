from std.sys.arg import argv
from std.testing import assert_equal, assert_true, TestSuite
from libft.string import ft_atoi
from push_swap.stack import Piles, sort_small, ops_to_string

def test_sort() raises:
    var vals: List[Int] = [3, 2, 1]
    var p = Piles(vals)
    sort_small(p)
    assert_true(p.is_sorted())
    var vals3: List[Int] = [2, 1]
    var p3 = Piles(vals3)
    p3.sa()
    assert_true(p3.is_sorted())

def main() raises:
    var args = argv()
    if len(args) >= 2:
        var vals = List[Int]()
        var i = 1
        while i < len(args):
            var v = ft_atoi(args[i])
            var j = 0
            while j < len(vals):
                if vals[j] == v:
                    print("Error")
                    return
                j += 1
            vals.append(v)
            i += 1
        var p = Piles(vals)
        sort_small(p)
        print(ops_to_string(p.ops), end="")
        return
    TestSuite.discover_tests[__functions_in_module()]().run()
