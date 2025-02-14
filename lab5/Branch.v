module Branch(
    input [31:0] op1,
    input [31:0] op2,
    input [1:0] br_type,
    output reg br
);
    always@(*) begin
        case(br_type) 
        2'b01://beq
        br = (op1 == op2);
        2'b10://blt
        begin
            if(op1[31] == op2[31]) begin
                br = (op1 < op2);
            end
            else begin
                br = (op1[31] > op2[31]);
            end
        end
        default: br = 1'b0;
        endcase
    end
endmodule