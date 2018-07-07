/* Team TECH GEEKS */

/*
*This test module is a part of the simple processor project issued by prof. Al-Habrouk
*This testBench module is used to simulate the activity of the processor
*Here, you may enter your two inputs (8 bit-wide each)
*You'll also have to enter opcode and the operand of the instruction you want to perform
*/

`include "altCPU.v"

module altCpuTestBench();

    altCpu testCpu(/*a*/8'hFF, /*b*/8'h01, /*instr*/8'h28);

endmodule