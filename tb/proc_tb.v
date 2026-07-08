`timescale 1ns/1ps

module processor_tb;

    reg clk, rst;

    processor my_proc (
        .clk(clk),
        .rst(rst)
    );

    reg test3;

    initial begin
        test3 = $test$plusargs("test3");
    end

    initial begin
        clk = 0;
        rst = 1;
        #20 rst = 0;
    end

    always #5 clk = ~clk;

    initial begin
        $dumpfile("sim/processor.vcd");
        $dumpvars(0, my_proc);

        $monitor(
        "t=%0t RD=%b WR=%b Erg=%b Ear=%b Epc=%b Eor=%b bus=%h",
        $time,
        my_proc.RD,
        my_proc.WR,
        my_proc.Erg,
        my_proc.Ear,
        my_proc.Epc,
        my_proc.Eor,
        my_proc.bus
    );
    end

    task check_reg;
        input [3:0] regnum;
        input [7:0] expected;
        begin
            if (my_proc.my_regs.regs[regnum] == expected)
                $display("PASS: R%0d = %h", regnum, expected);
            else
                $display("FAIL: R%0d Expected=%h Got=%h",
                         regnum,
                         expected,
                         my_proc.my_regs.regs[regnum]);
        end
    endtask

    initial begin
        wait(my_proc.halt);
        #10;

        if (test3) begin
            $display("\n----- TEST 3 RESULTS -----");

            check_reg(4'd0 , 8'hCB);
            check_reg(4'd1 , 8'h00);
            check_reg(4'd2 , 8'h80);
            check_reg(4'd3 , 8'h80);
            check_reg(4'd4 , 8'hD5);
            check_reg(4'd5 , 8'hD6);
            check_reg(4'd6 , 8'hB6);
            check_reg(4'd7 , 8'hBE);
            check_reg(4'd8 , 8'hFC);
            check_reg(4'd9 , 8'h01);
            check_reg(4'd10, 8'h01);
            check_reg(4'd11, 8'hFF);
        end
        /* Test3 in assembly
        movi R0, 12
        movi R1, 34
        movi R2, 56
        movi R3, 78
        movi R4, AA
        movi R5, 55
        movi R6, F0
        movi R7, 0F

        movs R0
        add  R1
        movd R2

        movs R2
        sub  R2
        movd R3

        movs R4
        xor  R5
        movd R4

        movs R4
        cmi  0F

        movs R4
        ani  F0
        movd R5

        movs R5
        ori  03
        movd R6

        movs R6
        xri  FF
        movd R7

        movs R7
        sbi  10
        movd R8

        movs R8
        adi  05
        movd R9

        movs R9
        and  R4
        movd R10

        movs R10
        or   R4
        movd R11

        movs R11
        xor  R1
        movd R0

        movs R0
        sub  R0
        movd R1

        movs R1
        ori  80
        movd R2

        movs R2
        ani  F0
        movd R3

        movs R3
        xri  55
        movd R4

        movs R4
        adi  01
        movd R5

        movs R5
        sbi  20
        movd R6

        movs R6
        or   R7
        movd R7

        stop
        */

        $finish;
    end

endmodule