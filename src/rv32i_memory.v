module memory_module #(
    parameter AMOUNT=2048
) (
    input wire clk,
    input wire write_enable,
    input wire read_enable,
    input wire [31:0] write_address,
    input wire [3:0]  write_byte,
    input wire [31:0] write_data,
    input wire [31:0] read_address,
    output reg [31:0] read_data
);
reg [31:0] memory[AMOUNT-1:0];
wire [$clog2(AMOUNT)-1:0] write_index;
wire [$clog2(AMOUNT)-1:0] read_index;
// This mean [start bit +: grab how many bit]
assign write_index = write_address[2 +: $clog2(AMOUNT)];
assign read_index  = read_address[2 +: $clog2(AMOUNT)];
always @(posedge clk) begin
    if (write_enable) begin
        if (write_byte[0]) begin
            memory[write_index][7:0] <= write_data[7:0];
        end
        if (write_byte[1]) begin
            memory[write_index][15:8] <= write_data[15:8];
        end
        if (write_byte[2]) begin
            memory[write_index][23:16] <= write_data[23:16];
        end
        if (write_byte[3]) begin
            memory[write_index][31:24] <= write_data[31:24];
        end
    end
    if (read_enable) begin
        read_data <= memory[read_index];
    end
end
endmodule
