module alu #(parameter WIDTH = 6)
(
    input [WIDTH-1:0] a,
    input [WIDTH-1:0] b,
    input [3:0] func,
    output reg [WIDTH-1:0] y,
    output reg of
);

always @(*) begin
    of = 1'b0;
    case (func)
        4'b0000: 
        begin 
            y = a + b;
            of = (a[5] & b[5] & ~y[5]) | (~a[5] & ~b[5] & y[5]);
        end
        4'b0001: 
        begin 
            y = a - b;
            of = (a[5] & ~b[5] & ~y[5]) | (~a[5] & b[5] & y[5]);
        end
        4'b0010: y = (a == b); 
        4'b0011: y = (a < b); 
        4'b0101: y = a & b;
        4'b0110: y = a | b;
        4'b0111: y = a ^ b;
        default: y = 0;
    endcase
end

endmodule
