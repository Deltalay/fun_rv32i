`timescale 1ns / 1ps

module rv32i_memory_tb (

);
    reg clk = 0;
    always #5 clk = ~clk;
    reg write_enable;
    reg read_enable;
    reg [31:0] write_data;
    wire [31:0] read_data;
    reg [31:0] read_address;
    reg [31:0] write_address;
    reg [3:0] write_byte;
    memory_module #(
    	.AMOUNT(64)
    ) v_memory_module (
    	.clk          (clk),
    	.write_enable (write_enable),
    	.read_enable  (read_enable),
    	.write_address(write_address),
    	.write_byte   (write_byte),
    	.write_data   (write_data),
    	.read_address (read_address),
    	.read_data    (read_data)
    );
    initial begin
        clk = 0;
        write_enable = 0;
        read_enable = 0;
        write_byte = 0;
        write_data = 0;
        #10
        write_enable = 1;
        write_address = 32'b00;
        write_byte = 4'b1111;
        write_data = 32'b11011;
        #15;
        write_enable = 0;
        read_enable = 1;
        read_address = 32'b00;
        #15;
        if (read_data == 32'b11011) begin
             $display("PASS: Read data = %d", read_data);
        end
        else begin
            $display("FAIL: Read data = %d", read_data);
        end
        #10;
        write_enable = 1;
        // address 4 mean the memory[1] because of 4D = 100B, where the last 2 bit
        // is use for write_byte.
        write_address = 32'd4;
        write_byte = 4'b0001;
        write_data = 32'h000000AA;
        #10;

        // Write only byte 1
        write_byte = 4'b0010;
        write_data = 32'h0000BB00;
        #10;

        // Write only byte 2
        write_byte = 4'b0100;
        write_data = 32'h00CC0000;
        #10;

        // Write only byte 3
        write_byte = 4'b1000;
        write_data = 32'hDD000000;
        #10;

        write_enable = 0;
        read_enable = 1;
        read_address = 32'd4;
        #10;
        if (read_data == 32'hDDCCBBAA) begin
             $display("PASS: Read data = %d", read_data);
        end
        else begin
            $display("FAIL: Read data = %d", read_data);
        end
        $finish;
    end
endmodule
