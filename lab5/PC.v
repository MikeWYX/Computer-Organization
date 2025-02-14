module PC(
    input [31:0] pc_next,
    input clk,
    input stall,
    input rst,
    output reg [31:0] pc_cur
);
    always @(posedge clk) begin
        if (rst) begin
            pc_cur <= 32'h2ffc;  
        end 
        else if (!stall) begin
            pc_cur <= pc_next;  
        end
    end

endmodule