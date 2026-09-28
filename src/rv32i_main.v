module top(
    input wire rst,
    input wire clk,
    output wire led
);
localparam GP_DATA_WIDTH = 32;
reg [23:0] clockCounter = 0;
reg [23:0] clockHalf = 13500000;
reg [0:0] led_reg = 1;
reg gp_write_enable = 0;
reg gp_read_enable = 1;
reg [4:0] gp_register = 1;
reg [GP_DATA_WIDTH-1:0] gp_write_data;
wire [GP_DATA_WIDTH-1:0] gp_read_data;
general_register #(
	.DATA_WIDTH(GP_DATA_WIDTH),
	.AMOUNT    (32)
 ) u_general_register  (
	.clk          (clk),
	.write_enable (gp_write_enable),
	.read_enable  (gp_read_enable),
	.register     (gp_register),
	.write_data   (gp_write_data),
	.register_data(gp_read_data)
);
reg [31:0] pc = 0;

always @(posedge clk or negedge rst) begin
    if (!rst) begin
        gp_write_enable <= 0;
        gp_read_enable <= 0;
        gp_write_data <= 0;
        pc <= 0;
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
