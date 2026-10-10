module general_register #(
    parameter DATA_WIDTH =32,
    parameter AMOUNT=32
) (
input wire clk,
input wire write_enable,
input wire [4:0] rd1,
input wire [4:0] rd2,
input wire [4:0] write_register,
input wire [DATA_WIDTH -1:0] write_data,
output wire [DATA_WIDTH -1:0] rd1_data,
output wire [DATA_WIDTH -1:0] rd2_data
);
reg [DATA_WIDTH -1:0] gp_register[AMOUNT-1:0];
always @(posedge clk) begin
    if (write_enable && (write_register != 5'd0))
        gp_register[write_register] <= write_data;
end
assign rd1_data =
    (rd1 == 5'd0) ? {DATA_WIDTH{1'b0}} : gp_register[rd1];
assign rd2_data =
        (rd2 == 5'd0) ? {DATA_WIDTH{1'b0}} : gp_register[rd2];
endmodule
