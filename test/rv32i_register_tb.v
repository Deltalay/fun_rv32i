`timescale 1ns / 1ps

module rv32i_register_tb (

);
    localparam DATA_WIDTH = 32;
    reg write_enable;
    reg clk;
    reg read_enable;
    reg [4:0] register;
    reg [DATA_WIDTH-1:0] write_data;
    wire [DATA_WIDTH-1:0] register_data;
    general_register #(
	.DATA_WIDTH(DATA_WIDTH),
	.AMOUNT    (32)
     ) u_general_register (
	.clk          (clk),
	.write_enable (write_enable),
	.read_enable  (read_enable),
	.register     (register),
	.write_data   (write_data),
	.register_data(register_data)
    );
    always #5 clk = ~clk;
    initial begin
        clk = 0;
        write_enable = 0;
        read_enable = 0;
        register = 0;
        write_data = 0;

        register = 5'd1;
        write_data = 32'd123;
        write_enable = 1;
        @(posedge clk);
        #1;

        write_enable = 0;
        register = 5'd1;
        read_enable = 1;
        #1
        if (register_data == 32'd123)
            $display("PASS: x1 = %d", register_data);
        else
            $error("FAIL: x1 expected 123, got %d", register_data);
        #10;
        read_enable = 1;
        register = 5'd0;
        #1
        if (register_data == 32'd0)
            $display("PASS: x0 = %d", register_data);
        else
            $error("FAIL: x0 expected 0, got %d", register_data);
        #1;

        read_enable = 0;
        write_enable = 1;
        register = 5'd0;
        write_data = 32'd134;
        @(posedge clk);
        #1;
        write_enable = 0;
        read_enable = 1;
        register = 5'd0;
        if (register_data == 32'd0)
            $display("PASS: x0 = %d", register_data);
        else
            $error("FAIL: x0 expected 0, got %d", register_data);
        $finish;
        end

endmodule
