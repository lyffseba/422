from std.testing import assert_equal, TestSuite
from ft_printf.printf import FormatArgs, ft_sprintf, ft_printf

def test_printf_basic() raises:
    var args = FormatArgs()
    args.add_int(42)
    args.add_str("hi")
    args.add_uint(UInt64(255))
    args.add_uint(UInt64(255))
    args.add_uint(UInt64(42))
    args.add_uint(UInt64(8))
    var s = ft_sprintf("%d %s %x %X %u %o %%", args)
    assert_equal(s, "42 hi ff FF 42 10 %")

def test_printf_char() raises:
    var args = FormatArgs()
    args.add_int(ord("Z"))
    assert_equal(ft_sprintf("%c", args), "Z")

def test_printf_neg() raises:
    var args = FormatArgs()
    args.add_int(-42)
    assert_equal(ft_sprintf("%d", args), "-42")

def main() raises:
    var args = FormatArgs()
    args.add_int(42)
    args.add_str("mojo")
    args.add_uint(UInt64(255))
    _ = ft_printf("hello %d %s %x\n", args)
    TestSuite.discover_tests[__functions_in_module()]().run()
