module RF(
    input clk, 
    input [2:0] ra0, 
    input [2:0] ra1, 
    input we, 
    input [2:0] wa, 
    input [3:0] wd, 
    output [3:0] rd0, 
    output [3:0] rd1 
);
    reg [3:0] regfile [0:7];
    assign rd0 = regfile[ra0];
    assign rd1 = regfile[ra1];
    always @(posedge clk) 
    begin
        if (we) 
            if(|wa)
                regfile[wa] = wd;
    end
endmodule