module fls (
    input clk, rst,
    input en,
    input [6:0] d,
    output reg [6:0] f
);

    parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10;
    reg [6:0] temp;
    reg [1:0] current_state, next_state;
    reg button_r1, button_r2;
    wire button_edge;

    always@(posedge clk)
    begin
        button_r1 <= en;
    end
    always@(posedge clk)
    begin
        button_r2 <= button_r1;
    end
    assign button_edge = button_r1 & (~button_r2);

    wire [6:0] alu_y;
    wire [3:0] func;
    wire alu_of;
    assign func = 4'h0;
    alu #(.WIDTH(7)) inst(.a(f), .b(temp), .func(func), .y(alu_y), .of(alu_of));

    //描述CS
    always @(posedge clk) 
    begin
        if (rst) 
            current_state <= S0;
        else begin
            if(button_edge)
                current_state <= next_state;
            else
                current_state <= current_state;
        end
    end

    //描述NS
    always @(*) 
    begin
        case (current_state)
            S0: next_state = S1;
            S1: next_state = S2;
            S2: next_state = S2;
            default: next_state = S0;
        endcase
    end

    //描述OUT
    always @(posedge clk) begin
        if(rst) temp <= 7'b0;
        else if(button_edge) begin
            case (current_state)
                S0: temp <= d;
                S2: temp <= f;
                default: temp <= temp;
            endcase
        end
    end
    always @(posedge clk) begin
        if(rst) f <= 7'b0;
        else if(button_edge) begin
            case (current_state)
                S0: f <= d;
                S1: f <= d;
                S2: f <= alu_y;
                default: f <= f;
            endcase
        end
    end
endmodule
