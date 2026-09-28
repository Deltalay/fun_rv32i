module general_register #(
    parameter DATA_WIDTH =32,
    parameter AMOUNT=32
) (
input wire clk,
input wire write_enable,
input wire read_enable,
input wire [4:0] register,
input wire [DATA_WIDTH -1:0] write_data,
output wire [DATA_WIDTH -1:0] register_data
);
reg [DATA_WIDTH -1:0] gp_register[AMOUNT-1:0];
always @(posedge clk) begin
    if (write_enable && (register != 5'd0))
        gp_register[register] <= write_data;
end
wire [DATA_WIDTH-1:0] read_data =
    read_enable ? gp_register[register] : {DATA_WIDTH{1'b0}};

assign register_data =
    (register == 5'd0) ? {DATA_WIDTH{1'b0}} : read_data;

endmodule
