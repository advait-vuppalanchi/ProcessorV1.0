`timescale 1ns/1ps

module control_tb;

    reg clk, rst;
    reg [7:0] IR;

    wire RD, WR, Lmr, Epc, Ipc, Lpc, Lir;
    wire Eor, Ror, Lor, Ear, Rar, Lar, Erg, Lrg;
    wire [2:0] Salu;
    wire [3:0] Srg;
    wire halt;

    control dut(
        .clk(clk),
        .rst(rst),
        .IR(IR),
        .RD(RD),
        .WR(WR),
        .Lmr(Lmr),
        .Epc(Epc),
        .Ipc(Ipc),
        .Lpc(Lpc),
        .Lir(Lir),
        .Eor(Eor),
        .Ror(Ror),
        .Lor(Lor),
        .Ear(Ear),
        .Rar(Rar),
        .Lar(Lar),
        .Erg(Erg),
        .Lrg(Lrg),
        .Salu(Salu),
        .Srg(Srg),
        .halt(halt)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("sim/control.vcd");
        $dumpvars(0, control_tb);

        clk = 0;
        rst = 1;
        IR = 8'h00;

        // Reset -> FETCH1
        #2;
        rst = 0;

        if(Epc && Lmr && Ipc)
            $display("Pass: FETCH1");
        else
            $display("Fail: FETCH1");

        // FETCH2
        @(negedge clk);
        #1;

        if(RD && Lir)
            $display("Pass: FETCH2");
        else
            $display("Fail: FETCH2");

        // NOP
        IR = 8'h00;

        @(negedge clk);
        #1;

        if(!(RD|WR|Lmr|Epc|Ipc|Lpc|Lir|
             Eor|Ror|Lor|Ear|Rar|Lar|Erg|Lrg))
            $display("Pass: NOP");
        else
            $display("Fail: NOP");

        // ADI
        IR = 8'h01;

        @(negedge clk);   // FETCH1
        @(negedge clk);   // FETCH2

        @(negedge clk);   // IMM3
        #1;

        if(Epc && Lmr && Ipc)
            $display("Pass: IMM3");
        else
            $display("Fail: IMM3");

        @(negedge clk);   // IMM4
        #1;

        if(RD && Lor)
            $display("Pass: IMM4");
        else
            $display("Fail: IMM4");

        @(negedge clk);   // ADI5
        #1;

        if(Ear && Lar && (Salu == `ADD))
            $display("Pass: ADI5");
        else
            $display("Fail: ADI5");

        // ADD R3
        IR = 8'h13;

        @(negedge clk);   // FETCH1
        @(negedge clk);   // FETCH2
        @(negedge clk);   // ALU3
        #1;

        if(Erg && Lor && (Srg==4'd3))
            $display("Pass: ALU3");
        else
            $display("Fail: ALU3");

        @(negedge clk);   // ADD4
        #1;

        if(Ear && Lar && (Salu==`ADD))
            $display("Pass: ADD4");
        else
            $display("Fail: ADD4");

        // MOVD R5
        IR = 8'h85;

        @(negedge clk);   // FETCH1
        @(negedge clk);   // FETCH2
        @(negedge clk);   // MOVD3
        #1;

        if(Ear && Lrg && (Srg==4'd5))
            $display("Pass: MOVD3");
        else
            $display("Fail: MOVD3");

        // STOP
        IR = 8'h07;

        @(negedge clk);   // FETCH1
        @(negedge clk);   // FETCH2
        @(negedge clk);   // STOP3
        #1;

        if(halt)
            $display("Pass: STOP");
        else
            $display("Fail: STOP");

        $finish;
    end

endmodule