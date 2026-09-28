`timescale 1ns / 1ps

module rv32i_decoder_tb (

);
    reg [31:0] instruction;
    wire [2:0] instruction_type;
    wire [4:0] rs1;
    wire [4:0] rs2;
    wire [4:0] rd;
    wire [2:0] funct3;
    wire [6:0] funct7;
    rv32i_decoder rv32i_decoder (
    	.instruction     (instruction),
    	.instruction_type(instruction_type),
    	.rs1             (rs1),
    	.rs2             (rs2),
    	.rd              (rd),
    	.funct3          (funct3),
    	.funct7          (funct7)
    );
    initial begin
        $monitor(
               "instruction=%h type=%d rs1=%d rs2=%d rd=%d funct3=%b funct7=%b",
               instruction,
               instruction_type,
               rs1,
               rs2,
               rd,
               funct3,
               funct7
           );
        instruction = 32'h007302B3;
        #10;
        // SUB x5, x6, x7
        instruction = 32'h407302B3;
        #10;
        // ADDI x5, x6, 10
        instruction = 32'h00A30293;
        #10;
        // LW x5, 0(x6)
        instruction = 32'h00032283;
        #10;
        // SW x7, 0(x6)
        instruction = 32'h00732023;
        #10;
        $finish;
    end
endmodule
