# Complete Instruction Set and Microinstructions

| Instruction | Opcode | Clk | Control Signals | Select Signals |
|------------|--------|-----|-----------------|----------------|
| **Fetch** | - | 1 | EPC, LMR, IPC | - |
| | | 2 | RD, LIR, LMS | - |
| **nop** | 00 | 3 | End | - |
| **adi xx** | 01 | 3 | EPC, LMR, IPC | - |
| | | 4 | RD, LOR | - |
| | | 5 | EAR, LAR, End | SALU ← ADD |
| **sbi xx** | 02 | 3 | EPC, LMR, IPC | - |
| | | 4 | RD, LOR | - |
| | | 5 | EAR, LAR, End | SALU ← SUB |
| **xri xx** | 03 | 3 | EPC, LMR, IPC | - |
| | | 4 | RD, LOR | - |
| | | 5 | EAR, LAR, End | SALU ← XOR |
| **ani xx** | 04 | 3 | EPC, LMR, IPC | - |
| | | 4 | RD, LOR | - |
| | | 5 | EAR, LAR, End | SALU ← AND |
| **ori xx** | 05 | 3 | EPC, LMR, IPC | - |
| | | 4 | RD, LOR | - |
| | | 5 | EAR, LAR, End | SALU ← OR |
| **cmi xx** | 06 | 3 | EPC, LMR, IPC | - |
| | | 4 | RD, LOR | - |
| | | 5 | EAR, End | SALU ← CMP |
| **stop** | 07 | 3 | End, StopClock | - |
| **ret\<FL\>** | 08–0F | 3 | EFL, End if \<FL\>’ | SFL ← \<FL\> |
| | | 4 | ESP, LMR, ISP | - |
| | | 5 | RD, LPC, End | - |
| **add \<R\>** | 10–1F | 3 | ERG, LOR | SRG ← \<R\> |
| | | 4 | EAR, LAR, End | SALU ← ADD |
| **sub \<R\>** | 20–2F | 3 | ERG, LOR | SRG ← \<R\> |
| | | 4 | EAR, LAR, End | SALU ← SUB |
| **xor \<R\>** | 30–3F | 3 | ERG, LOR | SRG ← \<R\> |
| | | 4 | EAR, LAR, End | SALU ← XOR |
| **and \<R\>** | 40–4F | 3 | ERG, LOR | SRG ← \<R\> |
| | | 4 | EAR, LAR, End | SALU ← AND |
| **or \<R\>** | 50–5F | 3 | ERG, LOR | SRG ← \<R\> |
| | | 4 | EAR, LAR, End | SALU ← OR |
| **cmp \<R\>** | 60–6F | 3 | ERG, LOR | SRG ← \<R\> |
| | | 4 | EAR, End | SALU ← CMP |
| **movs \<R\>** | 70–7F | 3 | ERG, LAR, End | SRG ← \<R\>, SALU ← PASS0 |
| **movd \<R\>** | 80–8F | 3 | EAR, LRG, End | SRG ← \<R\> |
| **movi \<R\> xx** | 90–9F | 3 | EPC, LMR, IPC | - |
| | | 4 | RD, LRG, End | SRG ← \<R\> |
| **stor \<R\>** | A0–AF | 3 | EAR, LMR | - |
| | | 4 | ERG, WR, End | SRG ← \<R\> |
| **load \<R\>** | B0–BF | 3 | EAR, LMR | - |
| | | 4 | RD, LRG, End | SRG ← \<R\> |
| **push \<R\>** | C0–CF | 3 | DSP | - |
| | | 4 | ESP, LMR | - |
| | | 5 | ERG, WR, End | SRG ← \<R\> |
| **pop \<R\>** | D0–DF | 3 | ESP, LMR, ISP | - |
| | | 4 | RD, LRG, End | SRG ← \<R\> |
| **jumpd\<FL\> xx** | E0–E7 | 3 | EPC, LMR, IPC, EFL, End if \<FL\>’ | SFL ← \<FL\> |
| | | 4 | RD, LPC, End | - |
| **jmpr\<FL\>** | E8–EF | 3 | EFL, End if \<FL\>’ | SFL ← \<FL\> |
| | | 4 | EAR, LPC, End | - |
| **cd\<FL\> xx** | F0–F7 | 3 | EPC, LMR, IPC, EFL, End if \<FL\>’ | SFL ← \<FL\> |
| | | 4 | RD, LOR, DSP | - |
| | | 5 | ESP, LMR | - |
| | | 6 | EPC, WR | - |
| | | 7 | EOR, LPC, End | - |
| **cr\<FL\>** | F8–FF | 3 | EFL, End if \<FL\>’ | SFL ← \<FL\> |
| | | 4 | DSP | - |
| | | 5 | ESP, LMR | - |
| | | 6 | EPC, WR | - |
| | | 7 | EAR, LPC, End | - |