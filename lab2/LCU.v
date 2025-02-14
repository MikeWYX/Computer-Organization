module LCU(
    //FIFO INPUT
    input clk, rst, 
    input enq, 
    input [3:0] in,
    input deq, 
    output reg [3:0] out, 
    output full,empty, 
    //RF INPUT
    input [3:0] rd,
    output [2:0] ra,
    output [2:0] wa,
    output [3:0] wd,
    output we,
    output reg [7:0] valid
);
    reg [2:0] RP;
    reg [2:0] WP;
    assign full = (&valid);
    assign empty = ~(|valid);
    assign ra = RP;
    assign we = enq && ~full && ~rst;
    assign wa = WP;
    assign wd = in;
    always @(posedge clk) 
    begin
        if (rst)begin
            valid <= 8'b0;
            RP <= 3'b0;
            WP <= 3'b0;
            out <= 3'b0;
        end
        else if(enq && ~full)begin
            valid[WP] <= 1'b1;
            WP <= WP + 3'b1;
        end
        else if(deq && ~emp)begin
            valid[RP] <= 1'b0;
            RP <= RP + 3'b1;
            out <= rd;
        end
    end
endmodule