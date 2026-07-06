`include "alu_defs.vh"

module control(
    input clk, rst,
    input [7:0] IR,
    output reg RD,WR,Lmr,Epc,Ipc,Lpc,Lir,
    output reg Eor,Ror,Lor,Ear,Rar,Lar,Erg,Lrg,
    output reg [2:0] Salu,
    output reg [3:0] Srg,
    output reg halt
);

    localparam FETCH1      = 6'd0;
    localparam FETCH2      = 6'd1;
    localparam NOP         = 6'd2; 
    localparam STOP3       = 6'd25;

    //Immediate instructions
    localparam IMM3        = 6'd3;
    localparam IMM4        = 6'd4;

    localparam ADI5        = 6'd5;
    localparam SBI5        = 6'd6;
    localparam XRI5        = 6'd7;
    localparam ANI5        = 6'd8;
    localparam ORI5        = 6'd9;
    localparam CMI5        = 6'd10;

    //Register-ALU instructions
    localparam ALU3        = 6'd11;

    localparam ADD4        = 6'd12;
    localparam SUB4        = 6'd13;
    localparam XOR4        = 6'd14;
    localparam AND4        = 6'd15;
    localparam OR4         = 6'd16;
    localparam CMP4        = 6'd17;

    // Data Movement Instructions
    localparam MOVS3       = 6'd18;
    localparam MOVD3       = 6'd19;
    localparam MOVI3       = 6'd20;
    localparam MOVI4       = 6'd21;

    // Memory Instructions
    localparam MEM3        = 6'd22;

    localparam STOR4       = 6'd23;
    localparam LOAD4       = 6'd24;

    reg [5:0] state, next_state;

    always @(negedge clk or posedge rst) begin
        if(rst) state <= FETCH1;
        else state <= next_state;
    end

    always @(*) begin
        {RD, WR, Lmr, Epc, Ipc, Lpc, Lir, 
        Eor, Ror, Lor, Ear, Rar, Lar, Erg, Lrg} = 15'b0;
        Srg = 3'd0; Salu = 3'd0; halt=0;

        case (state)
            FETCH1: begin Epc=1; Lmr=1; Ipc=1;      end
            FETCH2: begin RD=1;  Lir=1;             end
            NOP:    begin                           end
            STOP3:  begin halt=1;                   end

            //Immediate instructions
            IMM3:   begin Epc=1; Lmr=1; Ipc=1;      end
            IMM4:   begin RD=1;  Lor=1;             end

            ADI5:   begin Ear=1; Lar=1; Salu=`ADD;  end
            SBI5:   begin Ear=1; Lar=1; Salu=`SUB;  end
            XRI5:   begin Ear=1; Lar=1; Salu=`XOR;  end
            ANI5:   begin Ear=1; Lar=1; Salu=`AND;  end
            ORI5:   begin Ear=1; Lar=1; Salu= `OR;  end
            CMI5:   begin Ear=1;        Salu=`CMP;  end

            //Register-ALU instructions
            ALU3:   begin Erg=1; Lor=1; Srg=IR[3:0];end

            ADD4:   begin Ear=1; Lar=1; Salu=`ADD;  end
            SUB4:   begin Ear=1; Lar=1; Salu=`SUB;  end
            XOR4:   begin Ear=1; Lar=1; Salu=`XOR;  end
            AND4:   begin Ear=1; Lar=1; Salu=`AND;  end
            OR4:    begin Ear=1; Lar=1; Salu= `OR;  end
            CMP4:   begin Ear=1;        Salu=`CMP;  end

            //Data Movement Instructions
            MOVS3:  begin Erg=1; Lar=1; Srg=IR[3:0]; Salu=`PASS0; end
            MOVD3:  begin Ear=1; Lrg=1; Srg=IR[3:0]; end
            MOVI3:  begin Epc=1; Lmr=1; Ipc=1;         end
            MOVI4:  begin RD=1;  Lrg=1; Srg=IR[3:0]; end

            //Memory Instructions
            MEM3:   begin Ear=1; Lmr=1;              end
            STOR4:  begin Erg=1; WR=1;  Srg=IR[3:0]; end
            LOAD4:  begin RD=1;  Lrg=1; Srg=IR[3:0]; end
        endcase
    end

    always @(*) begin
        case(state)
            FETCH1: next_state = FETCH2;
            FETCH2: begin
                case (IR)
                    8'h00:       next_state = NOP;
                    8'h07:       next_state = STOP3;
                    8'h01:       next_state = IMM3;
                    8'h02:       next_state = IMM3;
                    8'h03:       next_state = IMM3;
                    8'h04:       next_state = IMM3;
                    8'h05:       next_state = IMM3;
                    8'h06:       next_state = IMM3;
                    default: case (IR[7:4])
                        4'h1:    next_state = ALU3;
                        4'h2:    next_state = ALU3;
                        4'h3:    next_state = ALU3;
                        4'h4:    next_state = ALU3;
                        4'h5:    next_state = ALU3;
                        4'h6:    next_state = ALU3;
                        4'h7:    next_state = MOVS3;
                        4'h8:    next_state = MOVD3;
                        4'h9:    next_state = MOVI3;
                        4'hA:    next_state = MEM3;
                        4'hB:    next_state = MEM3;
                        default: next_state = NOP;
                    endcase
                endcase
            end
            IMM3: next_state = IMM4;
            IMM4: begin
                case (IR)
                    8'h01:    next_state = ADI5;
                    8'h02:    next_state = SBI5;
                    8'h03:    next_state = XRI5;
                    8'h04:    next_state = ANI5;
                    8'h05:    next_state = ORI5;
                    8'h06:    next_state = CMI5;
                    default:  next_state = NOP;
                endcase
            end
            ADI5: next_state = FETCH1;
            SBI5: next_state = FETCH1;
            XRI5: next_state = FETCH1;
            ANI5: next_state = FETCH1;
            ORI5: next_state = FETCH1;
            CMI5: next_state = FETCH1;
            ALU3: begin
                case (IR[7:4])
                    4'h1:    next_state = ADD4;
                    4'h2:    next_state = SUB4;
                    4'h3:    next_state = XOR4;
                    4'h4:    next_state = AND4;
                    4'h5:    next_state = OR4;
                    4'h6:    next_state = CMP4;
                    default: next_state = NOP;
                endcase
            end
            ADD4:  next_state = FETCH1;
            SUB4:  next_state = FETCH1;
            XOR4:  next_state = FETCH1;
            AND4:  next_state = FETCH1;
            OR4:   next_state = FETCH1;
            CMP4:  next_state = FETCH1;
            MOVS3: next_state = FETCH1;
            MOVD3: next_state = FETCH1;
            MOVI3: next_state = MOVI4;
            MOVI4: next_state = FETCH1;
            MEM3: begin
                case (IR[7:4])
                    4'hA:    next_state = STOR4;
                    4'hB:    next_state = LOAD4;
                    default: next_state = NOP;
                endcase
            end
            STOR4: next_state = FETCH1;
            LOAD4: next_state = FETCH1;
            STOP3: next_state = STOP3;
        endcase
    end
endmodule