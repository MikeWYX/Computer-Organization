module NPC_SEL(
    input [31:0] pc_add4,
    input [31:0] pc_jal_br,
    input [31:0] pc_jalr,
    input jal,
    input jalr,
    input br,
    output reg [31:0] pc_next
);

    always@(*) begin
        if(jalr) begin
            pc_next = pc_jalr;
        end
        else begin
            if(jal | br) begin
            pc_next = pc_jal_br;
            end
            else begin
            pc_next = pc_add4;
            end
        end
    end
    
endmodule