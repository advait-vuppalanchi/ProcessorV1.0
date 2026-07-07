module processor(input clk, input rst);
    wire [7:0] bus;
    wire [7:0] alu_out, or_val, mar_out, ir_out;

    wire Lmr, Epc, Ipc, Lpc, Lir, Eor, Ror, Lor, Ear, Rar, Lar, Erg, Lrg, RD, WR, halt;
    wire [2:0] Salu;
    wire [3:0] Srg;

    pc my_pc (.clk(clk), .reset(rst), .Epc(Epc),
                .Lpc(Lpc), .Ipc(Ipc), .bus_in(bus), .bus_out(bus));

    mar_reg my_mar (.clk(clk), .Lmar(Lmr), .bus_in(bus),.mar_out(mar_out));

    memory my_mem (.clk(clk), .rd(RD), .wr(WR), .MARaddr(mar_out), 
                    .bus(bus));

    or_reg my_or (.clk(clk), .Eor(Eor), .Ror(Ror), .Lor(Lor), 
                    .or_to_alu(or_val), .bus(bus));

    ar_reg my_ar (.clk(clk), .Ear(Ear), .Lar(Lar), .Rar(Rar), 
                    .alu_out(alu_out), .bus(bus));

    alu my_alu (.a(bus), .b(or_val), .sel(Salu), .out(alu_out));

    ir_reg my_ir (.clk(clk), .Lir(Lir), .bus_in(bus), .ir_out(ir_out));

    regs my_regs (.clk(clk), .Erg(Erg), .Lrg(Lrg), .Srg(Srg), .bus(bus));

    control my_control (.clk(clk), .rst(rst), .IR(ir_out), .RD(RD), 
                        .WR(WR), .Lmr(Lmr), .Epc(Epc), .Ipc(Ipc), 
                        .Lpc(Lpc), .Lir(Lir), .Eor(Eor), .Ror(Ror), 
                        .Lor(Lor), .Ear(Ear), .Rar(Rar), .Lar(Lar), 
                        .Erg(Erg), .Lrg(Lrg), .Salu(Salu), .Srg(Srg), 
                        .halt(halt));
endmodule