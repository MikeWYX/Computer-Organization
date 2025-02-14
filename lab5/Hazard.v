module Hazard(
    input [4:0] rf_ra0_ex,
    input [4:0] rf_ra1_ex,
    input rf_re0_ex,
    input rf_re1_ex,
    input [4:0] rf_wa_mem,
    input rf_we_mem,
    input [1:0] rf_wd_sel_mem,
    input [31:0] alu_ans_mem,
    input [31:0] pc_add4_mem,
    input imm_mem,
    input [4:0] rf_wa_wb,
    input rf_we_wb,
    input [31:0] rf_wd_wb,
    input [1:0] pc_sel_ex,
    output reg rf_rd0_fe,
    output reg rf_rd1_fe,
    output reg [31:0] rf_rd0_fd,
    output reg [31:0] rf_rd1_fd,
    output reg stall_if,
    output reg stall_id,
    output reg stall_ex,
    output reg flush_if,
    output reg flush_id,
    output reg flush_ex,
    output reg flush_mem
);

    //foward
    always @(*) begin
        if (rf_we_mem && rf_wa_mem == rf_ra0_ex && rf_ra0_ex) begin
            case (rf_wd_sel_mem)
                2'b00: rf_rd0_fd = alu_ans_mem;
                2'b01: rf_rd0_fd = pc_add4_mem;
                2'b11: rf_rd0_fd = imm_mem;
                default: rf_rd0_fd = 1'b0;
            endcase
            if (rf_wd_sel_mem == 2'b10) begin
                rf_rd0_fe = 1'b0;
            end
            else begin
                rf_rd0_fe = 1'b1;
            end
        end
        else begin
            if (rf_we_wb && rf_wa_wb == rf_ra0_ex && rf_ra0_ex) begin
                rf_rd0_fd = rf_wd_wb;
                rf_rd0_fe = 1'b1;
            end
            else begin
                rf_rd0_fd = 1'b0;
                rf_rd0_fe = 1'b0;
            end
        end
    end

    always @(*) begin
        if (rf_we_mem && rf_wa_mem == rf_ra1_ex && rf_ra1_ex) begin
            case (rf_wd_sel_mem)
                2'b00: rf_rd1_fd = alu_ans_mem;
                2'b01: rf_rd1_fd = pc_add4_mem;
                2'b11: rf_rd1_fd = imm_mem;
                default: rf_rd1_fd = 1'b0;
            endcase
            if (rf_wd_sel_mem == 2'b10) begin
                rf_rd1_fe = 1'b0;
            end
            else begin
                rf_rd1_fe = 1'b1;
            end
        end
        else begin
            if (rf_we_wb && rf_wa_wb == rf_ra1_ex && rf_ra1_ex) begin
                rf_rd1_fd = rf_wd_wb;
                rf_rd1_fe = 1'b1;
            end
            else begin
                rf_rd1_fd = 1'b0;
                rf_rd1_fe = 1'b0;
            end
        end
    end

    //stall
    always @(*) begin
        if (rf_we_mem && rf_wa_mem == rf_ra0_ex && rf_ra0_ex && rf_wd_sel_mem == 2'b10) begin
            stall_ex = 1'b1;
            stall_id = 1'b1;
            stall_if = 1'b1;
            flush_mem = 1'b1;
        end
        else begin
            stall_ex = 1'b0;
            stall_id = 1'b0;
            stall_if = 1'b0;
            flush_mem = 1'b0;
        end
    end
                    
    //control
    always @(*) begin
        if (pc_sel_ex != 2'b0) begin
            flush_ex = 1'b1;
            flush_id = 1'b1;
            flush_if = 1'b1;
        end
        else begin
            flush_ex = 1'b0;
            flush_id = 1'b0;
            flush_if = 1'b0;
        end
    end

endmodule