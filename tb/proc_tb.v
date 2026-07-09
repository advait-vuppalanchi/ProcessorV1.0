`timescale 1ns/1ps

module processor_tb;

    reg clk, rst;

    processor my_proc (
        .clk(clk),
        .rst(rst)
    );

    reg test1,test2,test3,test4,test5;

    initial begin
        test1 = $test$plusargs("test1");
        test2 = $test$plusargs("test2");
        test3 = $test$plusargs("test3");
        test4 = $test$plusargs("test4");
        test5 = $test$plusargs("test5");
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
    end

    task check_reg;
        input [3:0] regnum;
        input [7:0] expected;
        begin
            if (my_proc.my_regs.regs[regnum] === expected)
                $display("PASS: R%0d = %d", regnum, expected);
            else
                $display("FAIL: R%0d Expected=%d Got=%d",
                         regnum,
                         expected,
                         my_proc.my_regs.regs[regnum]);
        end
    endtask

    initial begin
        wait(my_proc.halt);
        #10;

        if(test1) begin
            $display("\n----- TEST RESULTS -----");
            check_reg(4'd0 , 8'hxx);
            check_reg(4'd1 , 8'hxx);
            check_reg(4'd2 , 8'hxx);
            check_reg(4'd3 , 8'hxx);
            check_reg(4'd4 , 8'hxx);
            check_reg(4'd5 , 8'hxx);
            check_reg(4'd6 , 8'hxx);
            check_reg(4'd7 , 8'hxx);
            check_reg(4'd8 , 8'hxx);
            check_reg(4'd9 , 8'd67);
            check_reg(4'd10, 8'hxx);
            check_reg(4'd11, 8'hxx);
        end

        if(test2) begin
            $display("\n----- TEST RESULTS -----");
            check_reg(4'd8 , 8'd02);
            check_reg(4'd5 , 8'd69);
        end

        if(test3) begin
            $display("\n----- TEST RESULTS -----");

            check_reg(4'd0 , 8'h00);
            check_reg(4'd1 , 8'h00);
            check_reg(4'd2 , 8'h3C);
            check_reg(4'd3 , 8'hA5);
            check_reg(4'd4 , 8'hE1);
            check_reg(4'd5 , 8'h99);
            check_reg(4'd6 , 8'hD1);
            check_reg(4'd10, 8'hF0);
            check_reg(4'd11, 8'hF1);
        end

        if (test4) begin
            $display("\n----- TEST RESULTS -----");

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

        if(test5) begin
            $display("\n----- TEST RESULTS -----");

            check_reg(4'd0 , 8'hAA);
            check_reg(4'd1 , 8'h98);
            check_reg(4'd2 , 8'hAC);
            check_reg(4'd3 , 8'hA8);
            check_reg(4'd4 , 8'hEE);
            check_reg(4'd5 , 8'hCE);
            check_reg(4'd6 , 8'hCF);
            check_reg(4'd7 , 8'h56);
            check_reg(4'd8 , 8'hA9);
            check_reg(4'd9 , 8'hA0);
            check_reg(4'd10, 8'hF0);
            check_reg(4'd11, 8'hF1);
        end

        $finish;
    end

endmodule