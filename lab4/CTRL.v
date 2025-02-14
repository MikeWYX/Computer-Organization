module CTRL(
    input [31:0] inst,
    output jal,
    output jalr,
    output reg [1:0] br_type,
    output reg wb_en,
    output reg [1:0] wb_sel,
    output reg alu_op1_sel,
    output reg alu_op2_sel,
    output reg [3:0] alu_ctrl,
    output reg [2:0] imm_type,
    output reg mem_we
);
    wire [6:0] opcode;
    assign opcode = inst[6:0];

    assign jal = (opcode == 7 'b1101111);
    assign jalr = (opcode == 7'b1100111);

    //br_type
    always@(*) begin
        if(opcode == 7'b1100011) begin
            if(inst[14:12] == 3'b000) begin
                br_type = 2'b01;
            end
            else begin
                br_type = 2'b10;
            end
        end
        else begin
            br_type = 2'b00;
        end
    end

    //wb_en
    always@(*) begin
        if(opcode == 7'b1100011 || opcode == 7'b0100011) begin
            wb_en = 1'b0;
        end
        else begin
            wb_en = 1'b1;
        end
    end

    //wb_sel
    always@(*) begin
        case(opcode)
        7'b1101111,
        7'b1100111: wb_sel = 2'b01;
        7'b0000011: wb_sel = 2'b10;
        7'b0110111: wb_sel = 2'b11;
        default: wb_sel = 2'b00;
        endcase
    end

    //alu_op1_sel
    always@(*) begin
        if(opcode == 7'b1101111 || opcode == 7'b1100011 || opcode == 7'b0010111) begin
            alu_op1_sel = 1'b1;
        end
        else begin
            alu_op1_sel = 1'b0;
        end
    end

    //alu_op2_sel
    always@(*) begin
        if(opcode == 7'b0110011) begin
            alu_op2_sel = 1'b0;
        end
        else begin
            alu_op2_sel = 1'b1;
        end
    end

    //alu_ctrl
    always@(*) begin
        case(opcode)
        //7'b0010011: alu_ctrl = 4'b0101;
        default: alu_ctrl = 4'b0000;
        endcase
    end

    //imm_type
    always@(*) begin
        case(opcode)
        7'b0010011,
        7'b1100111,
        7'b0000011: //I-type
        imm_type = 3'b001;
        7'b1100011: //B-type
        imm_type = 3'b010;
        7'b0100011: //S-type
        imm_type = 3'b011;
        7'b1101111: //J-type
        imm_type = 3'b100;
        7'b0110111,
        7'b0010111: //U-type
        imm_type = 3'b101;
        default: imm_type = 3'b000;
        endcase
    end

    //mem_we
    always@(*) begin
        if(opcode == 7'b0100011) begin
            mem_we = 1'b1;
        end
        else begin
            mem_we = 1'b0;
        end
    end

endmodule