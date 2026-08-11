"""corewar — tiny educational VM (not full 42 Corewar binary compat).

Instruction set (byte code):
  0x00 HALT
  0x01 LOAD r, imm8     ; r = imm
  0x02 ADD  r_dst, r_a, r_b
  0x03 MOV  r_dst, r_src
  0x04 JMP  addr
  0x05 JZ   r, addr
  0x06 PRINT r
  0x07 DEC  r
"""

from libft.string import ft_itoa, byte_at, ft_atoi, ft_split

struct VM(Movable):
    var mem: List[Int]
    var reg: List[Int]
    var pc: Int
    var halted: Bool
    var output: List[String]

    def __init__(out self, program: List[Int]):
        self.mem = List[Int]()
        var i = 0
        while i < len(program):
            self.mem.append(program[i])
            i += 1
        # pad
        while len(self.mem) < 256:
            self.mem.append(0)
        self.reg = List[Int]()
        i = 0
        while i < 8:
            self.reg.append(0)
            i += 1
        self.pc = 0
        self.halted = False
        self.output = List[String]()

    def step(mut self) raises:
        if self.halted or self.pc < 0 or self.pc >= len(self.mem):
            self.halted = True
            return
        var op = self.mem[self.pc]
        self.pc += 1
        if op == 0:
            self.halted = True
        elif op == 1:  # LOAD r imm
            var r = self.mem[self.pc]; self.pc += 1
            var imm = self.mem[self.pc]; self.pc += 1
            self.reg[r] = imm
        elif op == 2:  # ADD d a b
            var d = self.mem[self.pc]; self.pc += 1
            var a = self.mem[self.pc]; self.pc += 1
            var b = self.mem[self.pc]; self.pc += 1
            self.reg[d] = self.reg[a] + self.reg[b]
        elif op == 3:  # MOV d s
            var d = self.mem[self.pc]; self.pc += 1
            var s = self.mem[self.pc]; self.pc += 1
            self.reg[d] = self.reg[s]
        elif op == 4:  # JMP addr
            var addr = self.mem[self.pc]; self.pc += 1
            self.pc = addr
        elif op == 5:  # JZ r addr
            var r = self.mem[self.pc]; self.pc += 1
            var addr = self.mem[self.pc]; self.pc += 1
            if self.reg[r] == 0:
                self.pc = addr
        elif op == 6:  # PRINT r
            var r = self.mem[self.pc]; self.pc += 1
            self.output.append(ft_itoa(self.reg[r]))
        elif op == 7:  # DEC r
            var r = self.mem[self.pc]; self.pc += 1
            self.reg[r] = self.reg[r] - 1
        else:
            raise Error("bad opcode")

    def run(mut self, max_steps: Int = 10000) raises:
        var steps = 0
        while not self.halted and steps < max_steps:
            self.step()
            steps += 1

def assemble_demo_countdown() -> List[Int]:
    """r0 = 3; loop: print r0; dec r0; jz r0 halt; jmp loop; halt"""
    # LOAD 0, 3
    # PRINT 0
    # DEC 0
    # JZ 0, halt
    # JMP loop
    # HALT
    var p = List[Int]()
    # 0: LOAD r0, 3
    p.append(1); p.append(0); p.append(3)
    # 3: PRINT r0
    p.append(6); p.append(0)
    # 5: DEC r0
    p.append(7); p.append(0)
    # 7: JZ r0, 12
    p.append(5); p.append(0); p.append(12)
    # 10: JMP 3
    p.append(4); p.append(3)
    # 12: HALT
    p.append(0)
    return p^

def assemble_source(src: String) raises -> List[Int]:
    """Very small assembler: lines like LOAD 0 3 / PRINT 0 / HALT."""
    var lines = List[String]()
    var cur = String()
    var i = 0
    while i < src.byte_length():
        var c = byte_at(src, i)
        if c == ord("\n"):
            lines.append(cur)
            cur = String()
        else:
            cur += chr(c)
        i += 1
    if cur.byte_length() > 0:
        lines.append(cur)
    var out = List[Int]()
    i = 0
    while i < len(lines):
        var line = lines[i]
        # strip comments
        if line.byte_length() == 0 or byte_at(line, 0) == ord(";"):
            i += 1
            continue
        var parts = ft_split(line, ord(" "))
        if len(parts) == 0:
            i += 1
            continue
        var op = parts[0]
        if op == "HALT":
            out.append(0)
        elif op == "LOAD" and len(parts) >= 3:
            out.append(1); out.append(ft_atoi(parts[1])); out.append(ft_atoi(parts[2]))
        elif op == "ADD" and len(parts) >= 4:
            out.append(2); out.append(ft_atoi(parts[1])); out.append(ft_atoi(parts[2])); out.append(ft_atoi(parts[3]))
        elif op == "MOV" and len(parts) >= 3:
            out.append(3); out.append(ft_atoi(parts[1])); out.append(ft_atoi(parts[2]))
        elif op == "JMP" and len(parts) >= 2:
            out.append(4); out.append(ft_atoi(parts[1]))
        elif op == "JZ" and len(parts) >= 3:
            out.append(5); out.append(ft_atoi(parts[1])); out.append(ft_atoi(parts[2]))
        elif op == "PRINT" and len(parts) >= 2:
            out.append(6); out.append(ft_atoi(parts[1]))
        elif op == "DEC" and len(parts) >= 2:
            out.append(7); out.append(ft_atoi(parts[1]))
        else:
            raise Error("asm error")
        i += 1
    return out^
