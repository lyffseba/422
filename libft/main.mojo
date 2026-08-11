from std.testing import assert_equal, assert_true, TestSuite
from libft.ctype import ft_isdigit, ft_toupper
from libft.string import (
    ft_atoi, ft_itoa, ft_itoa_base, ft_strcmp, ft_split, ft_strequ,
    ft_substr, ft_strchr, ft_strstr, ft_strtrim,
)
from libft.list import LinkedList
from libft.memory import ft_memcpy_list, ft_memcmp_list, ft_swap_int
from libft.put import ft_putendl

def test_ctype() raises:
    assert_true(ft_isdigit(ord("5")))
    assert_equal(ft_toupper(ord("a")), ord("A"))

def test_string() raises:
    assert_equal(ft_atoi("  -42"), -42)
    assert_equal(ft_itoa(1234), "1234")
    assert_equal(ft_itoa_base(UInt64(255), 16), "ff")
    assert_equal(ft_strcmp("ab", "ac"), ord("b") - ord("c"))
    assert_true(ft_strequ("mojo", "mojo"))
    var parts = ft_split("a,b,c", ord(","))
    assert_equal(len(parts), 3)
    assert_equal(parts[1], "b")
    assert_equal(ft_substr("abcdef", 2, 3), "cde")
    assert_equal(ft_strchr("hello", ord("l")), 2)
    assert_equal(ft_strstr("foobar", "bar"), 3)
    assert_equal(ft_strtrim("  x  "), "x")

def test_list() raises:
    var lst = LinkedList()
    lst.push_back(1)
    lst.push_back(2)
    lst.push_front(0)
    var vals = lst.to_list()
    assert_equal(len(vals), 3)
    assert_equal(vals[0], 0)
    assert_equal(vals[2], 2)

def test_memory() raises:
    var a: List[Int] = [1, 2, 3]
    var b = ft_memcpy_list(a)
    assert_equal(ft_memcmp_list(a, b, 3), 0)
    var x = 1
    var y = 2
    ft_swap_int(x, y)
    assert_equal(x, 2)
    assert_equal(y, 1)

def main() raises:
    ft_putendl("libft mojo self-check")
    TestSuite.discover_tests[__functions_in_module()]().run()
