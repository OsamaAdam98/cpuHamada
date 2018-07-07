/* Team TECH GEEKS */

/* 
*This memory is part of the simple processor project issued by prof. Al-Habrouk
*Memory is programmed as follows
*0x00 - load the value of the input 'a' to memory address 0
*0x11 - load the value of the input 'b' to memory address 1
*0x2x - add the two values and save them to memory address x
*0x3x - subtract the two values and save them to memory address x
*0x4x - multiply the two values and save them to memory address x
*0x5x - divide the two values and save them to memory address x
*0x6x - shift 'a' left by 'b' (a * (2^b)) and save them to memory address x
*0x7x - shift 'a' right by 'b' (a / (2^b)) and save them to memory address x
*This RAM module has 16 memory address each of them is 8 bit-wide (8*16)
*Notice that memory address 0 and 1 are reserved for a and b respectively
*/

`include "altParam.vh"

module altMemory(input[7:0] ramInput, input[7:0] instr, output[7:0] ramOut, input clk);

    reg[7:0] dataMemory[15:0]; //Main data storage
    reg[7:0] ramOutput; //output register
    reg[3:0] i; //a register to hold memory address
    integer j = 0; //an integer to be used for counting

    assign ramOut = ramOutput;

    always@(posedge clk) begin
        
        if(j == 0) begin //loading 'a' request
            ramOutput = `loadA;
            i = `loadA;
            j = j + 1;
        end
        else if(j == 1) begin //loading 'b' request
            ramOutput = `loadB;
            i = `loadB;
            j = j + 1;
        end
        
        else if (j > 1) begin //instruction request
            casez(instr)

                `loadA: ramOutput = `loadA; //legacy loading request, not necessarily used in current build
                `loadB: ramOutput = `loadB; //legacy loading request, not necessarily used in current build
                `add: ramOutput = `add; 
                `sub: ramOutput = `sub;
                `multiply: ramOutput = `multiply;
                `divide: ramOutput = `divide;
                `shiftLeft: ramOutput = `shiftLeft;
                `shiftRight: ramOutput = `shiftRight;

            endcase
            i = instr; //i is only 4-bit wide so it'll only hold the 4 LSBs of instr
        end    

    end

    always@(negedge clk) begin
        dataMemory[i] = ramInput; //integrate the output of the ALU into the memory address i
    end

endmodule