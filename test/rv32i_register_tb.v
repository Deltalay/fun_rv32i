`timescale 1ns / 1ps

module rv32i_register_tb (

);
    localparam DATA_WIDTH = 32;
    reg write_enable;
    reg clk;
    reg read_enable;
    reg [4:0] rd1;
    reg [4:0] rd2;
    reg [4:0] write_register;
    
    reg [DATA_WIDTH-1:0] write_data;
    wire [DATA_WIDTH-1:0] rd1_data;
    wire [DATA_WIDTH-1:0] rd2_data;
    general_register #(
	.DATA_WIDTH(DATA_WIDTH /* default 32 */),
	.AMOUNT    (32)
     ) u_general_register (
	.clk           (clk),
	.write_enable  (write_enable),
	.read_enable   (read_enable),
	.rd1           (rd1),
	.rd2           (rd2),
	.write_register(write_register),
	.write_data    (write_data),
	.rd1_data      (rd1_data),
	.rd2_data      (rd2_data)
    );
    always #10 clk = ~clk;
    initial begin
        clk = 0;
        write_enable = 0;
        read_enable = 0;
        rd1 = 0;
        rd2 = 0;
        write_register = 0;
        
        write_data = 0;

        write_register = 5'd1;
        write_data = 32'd123;
        write_enable = 1;
        @(posedge clk);
        #1;

        write_enable = 0;
        rd1 = 5'd1;
        read_enable = 1;
        #1
        if (rd1_data == 32'd123)
            $display("PASS: x1 = %d", rd1_data);
        else
            $error("FAIL: x1 expected 123, got %d", rd1_data);
        #1;
        write_register = 5'd2;
        write_data = 32'd456;
        write_enable = 1;
        @(posedge clk);
        #1;

        write_enable = 0;
        rd2 = 5'd2;
        read_enable = 1;
        #1
        if (rd2_data == 32'd456)
            $display("PASS: x2 = %d", rd2_data);
        else
            $error("FAIL: x2 expected 456, got %d", rd2_data);

        #1
        write_register = 5'd31;
        write_data = 32'hDEADBEEF;
        write_enable = 1;
        @(posedge clk);
        #1;

        write_enable = 0;
        rd1 = 5'd31;
        read_enable = 1;
        #1
        if (rd1_data == 32'hDEADBEEF)
            $display("PASS: x31 = %h", rd1_data);
        else
            $error("FAIL: x31 expected DEADBEEF, got %h", rd1_data);
        #10
        read_enable = 1;
        rd1 = 5'd0;
        #1
        if (rd1_data == 32'd0)
            $display("PASS: x0 = %d", rd1_data);
        else
            $error("FAIL: x0 expected 0, got %d", rd1_data);
        #1;

        read_enable = 0;
        write_enable = 1;
        write_register = 5'd0;
        write_data = 32'd134;
        @(posedge clk);
        #1;
        write_enable = 0;
        read_enable = 1;
        rd2 = 5'd0;
        if (rd2_data == 32'd0)
            $display("PASS: x0 = %d", rd2_data);
        else
            $error("FAIL: x0 expected 0, got %d", rd2_data);
        $finish;
        end

endmodule
