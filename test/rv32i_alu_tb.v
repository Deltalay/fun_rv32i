`timescale 1ns / 1ps

module rv32i_alu_tb (

);
reg [31:0] da;
reg [31:0] db;
reg clk;
reg [3:0] operation;
wire [31:0] dout;
wire zero;
localparam [3:0] ALU_ADD  = 4'b0000;
localparam [3:0] ALU_SUB  = 4'b0001;
localparam [3:0] ALU_SLL  = 4'b0010;
localparam [3:0] ALU_SLT  = 4'b0011;
localparam [3:0] ALU_SLTU = 4'b0100;
localparam [3:0] ALU_XOR  = 4'b0101;
localparam [3:0] ALU_SRL  = 4'b0110;
localparam [3:0] ALU_SRA  = 4'b0111;
localparam [3:0] ALU_OR   = 4'b1000;
localparam [3:0] ALU_AND  = 4'b1001;
rv32i_alu rv32i_alu (
	.da       (da),
	.db       (db),
	.operation(operation),
	.dout     (dout),
	.zero     (zero)
);
always #10 clk = ~clk;
initial begin
    clk = 0;
    da = 0;
    db = 0;
    operation = 0;
    #1
    da = 120;
    db = 100;
    operation = ALU_ADD;
    #1
    if (dout == 220)
        $display("ALU ADD PASS: %d",dout );
    else
        $display("ALU ADD FAIL: expect 220 got %d", dout);
    db = 120;
    operation = ALU_SUB;
    #1
    if (dout == 0)
        $display("ALU SUB PASS: %d", dout);
    else
        $display("ALU SUB FAIL: Expect 0 got %d",dout );
    if (zero==1)
        $display("ZERO PASS");
    else
        $display("ZERO FAIL GOT %d", zero);
    da = 32'b1;
    db = 32'b1;
    operation = ALU_AND;
    #1
    if (dout == 32'b1)
        $display("ALU AND PASS");
    else
        $display("ALU AND FAIL");
    operation = ALU_SLL;
    #1
    if (dout == 32'b10)
        $display("ALU SLL PASS" );
    else
        $display("ALU SLL FAIL");
    da = 32'd1;
    db = 32'd2;
    operation = ALU_SLT;
    #1
    if (dout == 32'd1)
        $display("ALU SLT PASS");
    else
        $display("ALU SLT FAIL: Expect 1 got %d", dout);

    da = 32'd2;
    db = 32'd1;
    operation = ALU_SLT;
    #1
    if (dout == 32'd0)
        $display("ALU SLT PASS");
    else
        $display("ALU SLT FAIL: Expect 0 got %d", dout);

    da = 32'd1;
    db = 32'd2;
    operation = ALU_SLTU;
    #1
    if (dout == 32'd1)
        $display("ALU SLTU PASS");
    else
        $display("ALU SLTU FAIL: Expect 1 got %d", dout);
    da = 32'd2;
    db = 32'd1;
    operation = ALU_SLTU;
    #1
    if (dout == 32'd0)
        $display("ALU SLTU PASS");
    else
        $display("ALU SLTU FAIL: Expect 0 got %d", dout);
    da = 32'b1010;
    db = 32'b1100;
    operation = ALU_XOR;
    #1
    if (dout == 32'b0110)
        $display("ALU XOR PASS");
    else
        $display("ALU XOR FAIL: Expect 6 got %d", dout);
    da = 32'b1000;
    db = 32'd1;
    operation = ALU_SRL;
    #1
    if (dout == 32'b0100)
        $display("ALU SRL PASS");
    else
        $display("ALU SRL FAIL: Expect 4 got %d", dout);
    da = 32'h80000000;
    db = 32'd1;
    operation = ALU_SRA;
    #1
    if (dout == 32'hC0000000)
        $display("ALU SRA PASS");
    else
        $display("ALU SRA FAIL: Expect 0xC0000000 got %h", dout);
    da = 32'b1010;
    db = 32'b1100;
    operation = ALU_OR;
    #1
    if (dout == 32'b1110)
        $display("ALU OR PASS");
    else
        $display("ALU OR FAIL: Expect 14 got %d", dout);

    da = 32'hFFFFFFFF;  // -1
    db = 32'd1;
    operation = ALU_SLT;
    #1
    if (dout == 32'd1)
        $display("ALU SLT NEGATIVE PASS");
    else
        $display("ALU SLT NEGATIVE FAIL: Expect 1 got %d", dout);

    da = 32'hFFFFFFFF;  // 4294967295 unsigned
    db = 32'd1;
    operation = ALU_SLTU;
    #1
    if (dout == 32'd0)
        $display("ALU SLTU UNSIGNED PASS");
    else
        $display("ALU SLTU UNSIGNED FAIL: Expect 0 got %d", dout);

    da = 32'h80000000;
    db = 32'd1;
    operation = ALU_SRL;
    #1
    if (dout == 32'h40000000)
        $display("ALU SRL HIGH BIT PASS");
    else
        $display("ALU SRL HIGH BIT FAIL: Expect 40000000 got %h", dout);

    da = 32'hFFFFFFFF;  // -1
    db = 32'd4;
    operation = ALU_SRA;
    #1
    if (dout == 32'hFFFFFFFF)
        $display("ALU SRA NEGATIVE PASS");
    else
        $display("ALU SRA NEGATIVE FAIL: Expect FFFFFFFF got %h", dout);
    $finish;
end
endmodule
