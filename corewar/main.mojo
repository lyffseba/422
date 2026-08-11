from std.testing import assert_equal, TestSuite
from corewar.vm import VM, assemble_demo_countdown, assemble_source

def test_countdown() raises:
    var prog = assemble_demo_countdown()
    var vm = VM(prog)
    vm.run()
    assert_equal(len(vm.output), 3)
    assert_equal(vm.output[0], "3")
    assert_equal(vm.output[2], "1")

def test_asm() raises:
    var src = "LOAD 1 10\nLOAD 2 5\nADD 0 1 2\nPRINT 0\nHALT\n"
    var prog = assemble_source(src)
    var vm = VM(prog)
    vm.run()
    assert_equal(vm.output[0], "15")

def main() raises:
    var prog = assemble_demo_countdown()
    var vm = VM(prog)
    vm.run()
    var i = 0
    while i < len(vm.output):
        print(vm.output[i])
        i += 1
    TestSuite.discover_tests[__functions_in_module()]().run()
