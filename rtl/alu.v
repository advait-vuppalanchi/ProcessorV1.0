`include "alu_defs.vh"

module alu (
    input  [7:0] a,
    input  [7:0] b,
    input  [2:0] sel,
    output reg [7:0] out
);

/*  ADD   = 3'd0;
    SUB   = 3'd1;
    AND   = 3'd2;
    OR    = 3'd3;
    XOR   = 3'd4;
    PASS0 = 3'd5;
    CMP   = 3'd6; */

always @(*) begin
    case (sel)
        `ADD:   out = a + b;
        `SUB:   out = a - b;
        `AND:   out = a & b;
        `OR:    out = a | b;
        `XOR:   out = a ^ b;
        `PASS0: out = a;
        `CMP:   out = a - b;
        default: out = 8'd0;
    endcase
end
endmodule