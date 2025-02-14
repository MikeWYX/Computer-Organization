module RF(
    input clk, 
    input [4:0] ra0, 
    input [4:0] ra1, 
    input [4:0] ra_dbg,
    input we, 
    input [4:0] wa, 
    input [31:0] wd, 
    output reg [31:0] rd0, 
    output reg [31:0] rd1,
    output reg [31:0] rd_dbg
);
    reg [31:0] regfile [0:31];

    always @(posedge clk) 
    begin
        if (we) 
            if (|wa)
                regfile[wa] = wd;
    end

    always @(*) begin
        if (|wa) begin
            if (we) begin
                if (ra0 == wa) begin
                    rd0 = wd;
                end
                else begin
                    rd0 = regfile[ra0];
                end
            end
            else begin
                rd0 = regfile[ra0];
            end
        end
        else begin
            if (we) begin
                if (ra0 == wa) begin
                    rd0 = 32'b0;
                end
                else begin
                    rd0 = regfile[ra0];
                end
            end
            else begin
                rd0 = regfile[ra0];
            end
        end
    end

    always @(*) begin
        if (|wa) begin
            if (we) begin
                if (ra1 == wa) begin
                    rd1 = wd;
                end
                else begin
                    rd1 = regfile[ra1];
                end
            end
            else begin
                rd1 = regfile[ra1];
            end
        end
        else begin
            if (we) begin
                if (ra1 == wa) begin
                    rd1 = 32'b0;
                end
                else begin
                    rd1 = regfile[ra1];
                end
            end
            else begin
                rd1 = regfile[ra1];
            end
        end
    end

    always @(*) begin
        if (|wa) begin
            if (we) begin
                if (ra_dbg == wa) begin
                    rd_dbg = wd;
                end
                else begin
                    rd_dbg = regfile[ra_dbg];
                end
            end
            else begin
                rd_dbg = regfile[ra_dbg];
            end
        end
        else begin
            if (we) begin
                if (ra_dbg == wa) begin
                    rd_dbg = 32'b0;
                end
                else begin
                    rd_dbg = regfile[ra_dbg];
                end
            end
            else begin
                rd_dbg = regfile[ra_dbg];
            end
        end
    end

    integer i;
    initial begin
        i = 0;
        while (i < 32) begin
            regfile[i] = 32'b0;
            i = i + 1;
        end
        regfile[2] = 32'h2ffc;
        regfile[3] = 32'h1800;
    end

endmodule