module ALU(
    input [31:0] alu_op1,
    input [31:0] alu_op2,
    input [3:0] alu_ctrl,
    output reg [31:0] alu_res
);

always @(*) begin
    case (alu_ctrl)
        4'b0000: alu_res = alu_op1 + alu_op2;
        4'b0001: alu_res = alu_op1 - alu_op2;
        4'b0010: alu_res = (alu_op1 == alu_op2); 
        4'b0011: alu_res = (alu_op1 < alu_op2); 
        4'b0101: alu_res = alu_op1 & alu_op2;
        4'b0110: alu_res = alu_op1 | alu_op2;
        4'b0111: alu_res = alu_op1 ^ alu_op2;
        default: alu_res = 1'b0;
    endcase
end

endmodule
