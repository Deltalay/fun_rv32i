module rv32i_alu
(
    input wire[31:0] da,
    input wire[31:0] db,
    input wire[3:0] operation,
    output reg[31:0] dout,
    output wire zero
);
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
always @(*) begin
    case (operation)
    ALU_ADD: dout = da + db;
    ALU_SUB: dout = da - db;
    ALU_AND: dout = da & db;
    ALU_OR:  dout = da | db;
    ALU_XOR: dout = da ^ db;
    ALU_SLTU: dout = (da < db) ? 32'b1 : 32'b0;
    ALU_SLL: dout = da << db[4:0];
    ALU_SRL: dout = da >> db[4:0];
    ALU_SRA: dout = $signed(da) >>> db[4:0];
    ALU_SLT: dout = ($signed(da) < $signed(db)) ? 32'b1 : 32'b0;
    default: begin
        dout = 32'b0;
    end
    endcase
end
assign zero = (dout == 32'b0);
endmodule
