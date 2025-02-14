module sedg(
    input a,
    input clk,
    output reg s,
    output wire p
 );
    reg st,pt;
    always@(posedge clk)
    begin
        st <= a;
    end
    always@(posedge clk)
    begin
        s <= st;
    end
    always@(posedge clk)begin
        pt <= s;
    end
    assign p = s && (~pt);
endmodule