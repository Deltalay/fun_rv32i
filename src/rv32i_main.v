module top(
    input wire rst,
    input wire clk,
    output wire led
);

reg [23:0] clockCounter = 0;
reg [23:0] clockHalf = 13500000;
reg [0:0] led_reg = 1;
always @(posedge clk or negedge rst) begin
    if (!rst) begin
        clockCounter <= 0;
    end
    else begin 
        if (clockCounter == clockHalf) begin
            led_reg <= led_reg ^ 1;
            clockCounter <= 0;
        end
        else clockCounter <= clockCounter + 1;
    end
end
assign led = led_reg;
endmodule