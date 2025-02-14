module ALU(
    input [31:0] alu_src1,
    input [31:0] alu_src2,
    input [3:0] alu_func,
    output reg [31:0] alu_ans
);

always @(*) begin
    case (alu_func)
        4'b0000: alu_ans = alu_src1 + alu_src2;
        4'b0001: alu_ans = alu_src1 - alu_src2;
        4'b0010: alu_ans = (alu_src1 == alu_src2); 
        4'b0011: alu_ans = (alu_src1 < alu_src2); 
        4'b0101: alu_ans = alu_src1 & alu_src2;
        4'b0110: alu_ans = alu_src1 | alu_src2;
        4'b0111: alu_ans = alu_src1 ^ alu_src2;
        default: alu_ans = 1'b0;
    endcase
end

endmodule
