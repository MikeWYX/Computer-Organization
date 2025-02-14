module FIFO(
    input clk, rst, 
    input enq, 
    input [3:0] in, 
    input deq, 
    output [3:0] out, 
    output full, empty, 
    output [2:0] an, 
    output [3:0] seg 
);
    wire enq_edge;
    wire deq_edge;
    wire we;
    wire [2:0] ra0, ra1, wa;
    wire [3:0] rd0, rd1, wd;
    wire [7:0] valid;

    RF RF(
        .clk(clk),
        .ra0(ra0),
        .ra1(ra1),
        .we(we),
        .wa(wa),
        .wd(wd),
        .rd0(rd0),
        .rd1(rd1)
    );
    sedg sedg1(
        .clk(clk),
        .a(enq),
        .s(s),
        .p(enq_edge)
    );
    sedg sedg2(
        .clk(clk),
        .a(deq),
        .s(s),
        .p(deq_edge)
    );
    LCU LCU(
        .clk(clk),
        .rst(rst),
        .enq(enq_edge),        
        .in(in),
        .deq(deq_edge),
        .out(out),
        .full(full),
        .empty(empty),
        .rd(rd0),
        .ra(ra0),
        .wa(wa),
        .wd(wd),
        .we(we),
        .valid(valid)
    );
    SDU SDU(
        .clk(clk),
        .data(rd1),
        .valid(valid),
        .addr(ra1),
        .an(an),
        .seg(seg)
    );
endmodule