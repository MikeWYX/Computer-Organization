module Encoder(
    input jal,
    input jalr,
    input br,
    output reg [1:0] pc_sel
);

    always @(*) begin
        if (jalr) begin
            pc_sel = 2'b01;
        end
        else begin
            if (jal|br) begin
                pc_sel = 2'b11;
            end
            else begin
                pc_sel = 2'b0;
            end
        end
    end

endmodule
