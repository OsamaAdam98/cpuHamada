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
*0x8x - jumps to instruction in memory address x, this is only available in mode 1
*This RAM module has 16 memory address each of them is 8 bit-wide (8*16)
*Notice that memory address 0 and 1 are reserved for a and b respectively
*This is mostly true for mode 0 only, check readme for mode descriptions
*/

/* Search for #programme to find the programmable instruction memory */

`include "altParam.vh"

module altMemory(input[7:0] ramInput, input[7:0] instr, output[7:0] ramOut, input mode, input clk);

    reg[7:0] dataMemory[15:0]; //Main data storage
    reg[7:0] instrMem[15:0]; //instruction memory for mode 1
    reg[7:0] ramOutput; //output register
    reg[3:0] i; //a register to hold memory address
    integer j = 0; //an integer to be used for counting
    integer k = 0; //another integer used for counting

    assign ramOut = ramOutput;

    always@(posedge clk) begin
        //Legacy code
        /*
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
        */
        if(mode == 0) begin //instruction request
            casez(instr)

                `loadA: ramOutput = `loadA; 
                `loadB: ramOutput = `loadB; 
                `add: ramOutput = `add; 
                `sub: ramOutput = `sub;
                `multiply: ramOutput = `multiply;
                `divide: ramOutput = `divide;
                `shiftLeft: ramOutput = `shiftLeft;
                `shiftRight: ramOutput = `shiftRight;

            endcase
            i = instr; //i is only 4-bit wide so it'll only hold the 4 LSBs of instr
        end    
        else if(mode == 1) begin
            if(j == 0) begin //This will only be true on the start of the simulation
            /* Put your own programme here */
            /* This is my default programme which performs all the instructions */
            /* Change as you see fit as long as memory addresses don't clash */
            /* #programme */
                instrMem[0] = `oneAdd;
                instrMem[1] = `oneSub;
                instrMem[2] = `oneMultiply;
                instrMem[3] = `oneDivide;
                instrMem[4] = `oneShiftLeft;
                instrMem[5] = `oneShiftRight;
                instrMem[6] = `oneLoadA;
                instrMem[7] = `oneLoadB;
                /* Jump instruction, use wisely. */
                //instrMem[8] = 8'h80;
                j = j + 1; 
            end
            /* Jump condition begins */
            else if(j > 0 && k < 9) begin
                if((instrMem[k] >> 4) == 8) begin
                    i = instrMem[k];
                    k = i;
                end
            /* Jump condition ends */
                else begin
                    ramOutput <= instrMem[k]; //send the instruction to the ALU
                    i = instrMem[k]; //i is only 4-bit wide so it'll only hold the 4 LSBs of instrMem[x]
                    k = k + 1;
                end
            end
        end

    end

    always@(negedge clk) begin
        dataMemory[i] = ramInput; //integrate the output of the ALU into the memory address i
    end

endmodule
