module top(
    input wire rst,
    input wire clk,
    output wire led
);

reg [23:0] clockCounter = 0;
reg [23:0] clockHalf = 13500000;
reg [0:0] led_reg = 1;
reg [31:0] x_regs [31:0];
reg [31:0] pc = 0;

always @(posedge clk or negedge rst) begin
    if (!rst) begin
        x_regs[0] <= 32'b0;
        clockCounter <= 0;
    end
    else begin
        x_regs[0] <= 32'b0;
        if (clockCounter == clockHalf) begin
            led_reg <= led_reg ^ 1;
            x_regs[1] <= led_reg;
            clockCounter <= 0;
        end
        else clockCounter <= clockCounter + 1;
    end
end
assign led = led_reg;
endmodule
