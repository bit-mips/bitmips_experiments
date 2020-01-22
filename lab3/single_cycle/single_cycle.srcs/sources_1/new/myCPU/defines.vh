`define RST_ENABLE      1'b0
`define RST_DISABLE     1'b1

// alu op
`define ALU_ADD         3'b001
`define ALU_SUB         3'b010
`define ALU_OR          3'b100

// decode
// R type, op == 6'b000000, funct = instr
`define INST_ADD        6'b100000

// I type, op == instr
`define INST_LUI        6'b001111
`define INST_ORI        6'b001101
`define INST_SW         6'b101011
`define INST_LW         6'b100011
`define INST_BEQ        6'b000100

// J type op = instr
`define INST_J          6'b000010