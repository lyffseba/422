from std.sys.arg import argv
from std.io.file import open
from std.testing import assert_equal, TestSuite
from get_next_line.gnl import GetNextLine, read_lines

def test_gnl_basic() raises:
    var f = open("/tmp/gnl_422.txt", "w")
    f.write("one\ntwo\nthree")
    f.close()
    var lines = read_lines("/tmp/gnl_422.txt")
    assert_equal(len(lines), 3)
    assert_equal(lines[0], "one")
    assert_equal(lines[2], "three")

def main() raises:
    var args = argv()
    if len(args) >= 2:
        var gnl = GetNextLine.from_path(args[1])
        while True:
            var line = gnl.next_line()
            if not line:
                break
            print(line.value())
        return
    TestSuite.discover_tests[__functions_in_module()]().run()
