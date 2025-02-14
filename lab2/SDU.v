module SDU(
    input clk,
    input [3:0] data,
    input [7:0] valid,
    output reg [2:0] addr,
    output [2:0] an,
    output [3:0] seg
);
    reg [9:0] count;
    always @(posedge clk) 
    begin
        count <= count + 10'b1;
        addr <= count[9:7];
    end
    assign an = addr;
    assign seg = valid[an] ? data : 4'h0;
endmodule