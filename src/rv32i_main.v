module top(
    input wire rst,
    input wire clk,
    output wire led
);
localparam [2:0] PL_INSTRUCTION_FETCH = 3'b000;
localparam [2:0] PL_INSTRUCTION_DECODE = 3'b001;
localparam [2:0] PL_EXECUTE = 3'b010;
localparam [2:0] PL_MEMORY = 3'b011;
localparam [2:0] PL_WRITE_BACK = 3'b100;

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
reg mem_write_enable = 0;
reg mem_read_enable = 1;
reg [31:0] mem_read_address;
reg [31:0] mem_write_address;
wire [31:0] mem_read_data;
reg [31:0] mem_write_data;
reg [3:0] mem_write_byte;
memory_module u_memory_module (
	.clk          (clk),
	.write_enable (mem_write_enable),
	.read_enable  (mem_read_enable),
	.write_address(mem_write_address),
	.write_byte   (mem_write_byte),
	.write_data   (mem_write_data),
	.read_address (mem_read_address),
	.read_data    (mem_read_data)
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
            mem_write_address <= 2;
            clockCounter <= 0;
        end
        else clockCounter <= clockCounter + 1;
    end
end
assign led = led_reg;
endmodule
