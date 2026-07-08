module memory(
    input clk,
    input rd,
    input wr,
    input [7:0] MARaddr,
    inout [7:0] bus
);

    reg [7:0] mem [0:255];

    //filling the memory with instructions
    string hexfile;
    initial begin
        if (!$value$plusargs("hexfile=%s", hexfile))
            hexfile = "programs/test1.hex";

        $readmemh(hexfile, mem);
    end
    
    assign bus = rd? mem[MARaddr] : 8'bz;

    always @(negedge clk) begin
        if(wr) mem[MARaddr] <= bus;
    end
endmodule