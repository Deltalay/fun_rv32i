module rv32i_decoder (
    input  wire [31:0] instruction,
    output reg  [2:0]  instruction_type,
    output wire [4:0]  rs1,
    output wire [4:0]  rs2,
    output wire [4:0]  rd,
    output wire [2:0]  funct3,
    output wire [6:0]  funct7
);
wire [6:0] opcode;
localparam TYPE_R = 3'd0;
localparam TYPE_I = 3'd1;
localparam TYPE_S = 3'd2;
localparam TYPE_B = 3'd3;
localparam TYPE_U = 3'd4;
localparam TYPE_J = 3'd5;
localparam TYPE_INVALID = 3'd7;
assign opcode = instruction[6:0];
assign rd = instruction[11:7];
assign rs1 = instruction[19:15];
assign rs2 = instruction[24:20];
assign funct3 = instruction[14:12];
assign funct7 = instruction[31:25];
always @(*) begin
    case (opcode)
        default: begin
            instruction_type = TYPE_INVALID;
        end
    endcase
end
endmodule
