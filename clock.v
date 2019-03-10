module clock(output reg clk = 0);

    always begin
        #25 //clock frequency.
        clk = ~clk;
    end

endmodule