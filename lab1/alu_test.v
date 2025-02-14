module alu_test (
    input clk,
    input en,
    input [1:0] sel,
    input [5:0] x,
    output reg [5:0] y,
    output reg of
);

reg enf, ena, enb;
reg [3:0] func;
reg [5:0] a, b;
wire [5:0] alu_y;
wire alu_of;

//译码生成寄存器使能信号
always @(*)
begin
    if(en) begin
        case(sel)
            2'b00: 
            begin
                ena = 1; enb = 0; enf = 0;
            end
            2'b01: 
            begin
                ena = 0; enb = 1; enf = 0;
            end
            2'b10: 
            begin
                ena = 0; enb = 0; enf = 1;
            end
            default: 
            begin
                ena = 0; enb = 0; enf = 0;
            end
        endcase
    end
    else begin
        ena = 0; enb = 0; enf = 0;
    end
end
        
//alu分时输入
always @(posedge clk) 
begin
    if (en) begin
        if(enf)
            func <= x[3:0];
        if(ena)
            a <= x;
        if(enb)
            b <= x;
    end
end

//调用alu模块
alu inst (.a(a), .b(b), .func(func), .y(alu_y), .of(alu_of));
always @(posedge clk)
begin
    y <= alu_y;
    of <= alu_of;
end

endmodule
