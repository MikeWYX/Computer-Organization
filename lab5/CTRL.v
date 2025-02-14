module CTRL(
    input [31:0] inst,
    output jal,
    output jalr,
    output reg [1:0] br_type,
    output reg rf_we,
    output reg [1:0] rf_wd_sel,
    output reg alu_src1_sel,
    output reg alu_src2_sel,
    output reg [3:0] alu_func,
    output reg [2:0] imm_type,
    output reg mem_we,
    output reg rf_re0,
    output reg rf_re1
);
    wire [6:0] opcode;
    assign opcode = inst[6:0];
    wire [4:0] rd;
    assign rd = inst[11:7];
    wire [4:0] rs1;
    assign rs1 = inst[19:15];
    wire [4:0] rs2;
    assign rs2 = inst[19:15];

    assign jal = (opcode == 7 'b1101111);
    assign jalr = (opcode == 7'b1100111);

    //br_type
    always @(*) begin
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

    //rf_we
    always @(*) begin
        if(opcode == 7'b1100011 || opcode == 7'b0100011 || rd == 5'b0) begin
            rf_we = 1'b0;
        end
        else begin
            rf_we = 1'b1;
        end
    end

    //rf_wd_sel
    always @(*) begin
        case(opcode)
        7'b1101111,
        7'b1100111: rf_wd_sel = 2'b01;
        7'b0000011: rf_wd_sel = 2'b10;
        7'b0110111: rf_wd_sel = 2'b11;
        default: rf_wd_sel = 2'b00;
        endcase
    end

    //alu_src1_sel
    always @(*) begin
        if(opcode == 7'b1101111 || opcode == 7'b1100011 || opcode == 7'b0010111) begin
            alu_src1_sel = 1'b1;
        end
        else begin
            alu_src1_sel = 1'b0;
        end
    end

    //alu_src2_sel
    always @(*) begin
        if(opcode == 7'b0110011) begin
            alu_src2_sel = 1'b0;
        end
        else begin
            alu_src2_sel = 1'b1;
        end
    end

    //alu_func
    always @(*) begin
        case(opcode)
        //7'b0010011: alu_func = 4'b0101;
        default: alu_func = 4'b0000;
        endcase
    end

    //imm_type
    always @(*) begin
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
    always @(*) begin
        if(opcode == 7'b0100011) begin
            mem_we = 1'b1;
        end
        else begin
            mem_we = 1'b0;
        end
    end

    //rf_re
    always @(*) begin
        if(opcode == 7'b0110111 || opcode == 7'b0010111 || opcode == 7'b1101111 || rs1 == 5'b0) begin
            rf_re0 = 1'b0;
        end
        else begin
            rf_re0 = 1'b1;
        end
    end

    always @(*) begin
        if(opcode == 7'b1100011 || opcode == 7'b0100011 || opcode == 7'b0110011 && rs2 != 5'b0) begin
            rf_re1 = 1'b1;
        end
        else begin
            rf_re1 = 1'b0;
        end
    end
endmodule