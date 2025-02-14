`timescale 1ns / 1ps

module Shift_reg(
    input rst,
    input clk,          // Work at 100MHz clock

    input [31:0] din,   // Data input  
    input [3:0] hex,    // Hexadecimal code for the switches
    input add,          // Add signal
    input del,          // Delete signal
    input set,          // Set signal
    
    output reg [31:0] dout  // Data output
);
    reg [31:0] data;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            data <= 32'b0; 
        end 
        else if (set) begin
            data <= din; 
        end 
        else if (add) begin
            data[31:0] <= {dout[27:0], hex[3:0]};
        end 
        else if (del) begin
            data <= dout >> 4; 
        end
    end

endmodule

