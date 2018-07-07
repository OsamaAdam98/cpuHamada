/* Team TECH GEEKS */

/*
*This CPU module is the main part of the simple processor project issued by prof. Al-Habrouk
*This part merely connects the other part of the CPU together (ALU and memory)
*/

`include "altAlu.v"
`include "clock.v"

module altCpu(input[7:0] a, input[7:0] b, input[7:0] inputInstr);

    wire[7:0] ramInst;
    wire[7:0] aluOut;
    wire clk;
    
    clock pulse(clk);
    altAlu cpuAlu(a, b, ramInst, aluOut, carryFlag, compFlag, clk);
    altMemory cpuMemory(aluOut, inputInstr, ramInst, clk);

endmodule