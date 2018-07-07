/* Reference: http://www.fpga4student.com/2017/06/Verilog-code-for-ALU.html */
/* Team TECH GEEKS */

/*
*This ALU is part of the simple processor project issued by prof. Al-Habrouk
*This ALU recieves its instructions from the RAM (see comments on memory for programme)
*/

`include "altMemory.v"

module altAlu(input reg[7:0] a, input reg[7:0] b, input[7:0] ramInst, output[7:0] aluResult, reg carryFlag = 0, reg compFlag = 0, input clk);

    reg[7:0] resultReg;
    wire[8:0] temp;

    assign aluResult = resultReg;
    assign temp = {1'b0,a} + {1'b0,b};

    always@(posedge clk) begin

        

        #10
        casez(ramInst)

            `loadA: resultReg = a; //load a
            `loadB: resultReg = b; //load b
            `multiply: resultReg = a * b; //multiply
            `divide: resultReg = a / b; //divide
            `shiftLeft: resultReg = a << b; //shift left
            `shiftRight: resultReg = a >> b; //shift right
            `add:   begin
                        resultReg = a + b;
                        if(temp[8])
                            carryFlag <= 1;
                        else
                            carryFlag <= 0;
                    end
            `sub:   begin
                        if(a<b) begin
                            resultReg = (((a - b) ^ 8'hFF) + 1); //two's complement
                            compFlag <= 1;
                        end
                        else begin
                            resultReg = a - b; //normal subraction
                            compFlag <= 0;
                        end
                    end
        endcase


    end

    always@(posedge clk) begin
        #20
        if((ramInst == `sub) && (b > a)) begin: ifLoop
            resultReg = ((resultReg ^ 8'hFF) + 1); //two's complement
        end
    end

endmodule