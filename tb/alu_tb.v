`timescale 1ns/1ps
`include "alu_defs.vh"

module alu_tb;

reg [7:0] a,b;
reg [2:0] sel;
wire [7:0] out;

alu my_alu(
    .a(a),
    .b(b),
    .sel(sel),
    .out(out)
);

task check;
    input [7:0] expected;
    begin
        #1;
        if(out==expected) $display("Pass -- sel=%0d , b=%h , expcted=%h , got=%h",sel,a,b,expected,out);
        else $display("Fail -- sel=%0d , b=%h , expcted=%h , got=%h",sel,a,b,expected,out);
    end
endtask

initial begin
    $dumpfile("sim/alu.vcd");
    $dumpvars(0, alu_tb);

    //ADD
    a=8'd4;b=8'd3;sel=`ADD;check(8'd7);
    a=8'd21;b=8'd4;sel=`ADD;check(8'd25);
    a=8'd250;b=8'd6;sel=`ADD;check(8'd0);

    //SUB
    a=8'd10; b=8'd3;  sel=`SUB; check(8'd7);
    a=8'd5;  b=8'd5;  sel=`SUB; check(8'd0);
    a=8'd3;  b=8'd5;  sel=`SUB; check(8'd254);

    //AND
    a=8'hFF; b=8'h0F; sel=`AND; check(8'h0F);
    a=8'hAA; b=8'hCC; sel=`AND; check(8'h88);
    a=8'h55; b=8'hAA; sel=`AND; check(8'h00);

    //OR
    a=8'hF0; b=8'h0F; sel=`OR; check(8'hFF);
    a=8'hAA; b=8'h55; sel=`OR; check(8'hFF);
    a=8'h00; b=8'h81; sel=`OR; check(8'h81);

    //XOR
    a=8'hAA; b=8'hCC; sel=`XOR; check(8'h66);
    a=8'hFF; b=8'hFF; sel=`XOR; check(8'h00);
    a=8'h55; b=8'hAA; sel=`XOR; check(8'hFF);

    //PASSO
    a=8'h5A; b=8'h00; sel=`PASS0; check(8'h5A);
    a=8'hFF; b=8'h12; sel=`PASS0; check(8'hFF);
    a=8'h00; b=8'hAB; sel=`PASS0; check(8'h00);

    //CMP
    a=8'd9;  b=8'd4;  sel=`CMP; check(8'd5);
    a=8'd7;  b=8'd7;  sel=`CMP; check(8'd0);
    a=8'd2;  b=8'd5;  sel=`CMP; check(8'd253);

    $display("Done");
    $finish;
end
endmodule
