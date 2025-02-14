module MEM(
    input clk,

    // MEM Data BUS with CPU
	// IM port
    input [31:0] im_addr,
    output [31:0] im_dout,
	
	// DM port
    input  [31:0] dm_addr,
    input dm_we,
    input  [31:0] dm_din,
    output [31:0] dm_dout,

    // MEM Debug BUS
    input [31:0] mem_check_addr,
    output [31:0] mem_check_data
);
   
   // TODO: Your IP here.
   // Remember that we need [9:2]?
    wire [7:0] dpra;
    wire [7:0] a;
    wire [7:0] da;
    assign da = dm_addr[9:2];
    assign dpra = mem_check_addr[9:2];
    assign a = im_addr[9:2];

    data_mem data_mem(
        .a(da),
        .d(dm_din),
        .dpra(dpra),
        .we(dm_we),
        .clk(clk),
        .spo(dm_dout),
        .dpo(mem_check_data)
    );

    inst_mem inst_mem(
        .a(a),
        .spo(im_dout)
    );

endmodule