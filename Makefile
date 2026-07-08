alu:
	iverilog -Irtl -o sim/alu_sim rtl/alu.v tb/alu_tb.v
	vvp sim/alu_sim

wave_alu:
	gtkwave sim/alu.vcd

regs:
	iverilog -o sim/regs_sim rtl/regs.v tb/regs_tb.v
	vvp sim/regs_sim

wave_regs:
	gtkwave sim/regs.vcd

pc:
	iverilog -o sim/pc_sim rtl/pc.v tb/pc_tb.v
	vvp sim/pc_sim

wave_pc:
	gtkwave sim/pc.vcd

ar:
	iverilog -o sim/ar_sim rtl/func_regs.v tb/ar_tb.v
	vvp sim/ar_sim

wave_ar:
	gtkwave sim/ar_reg.vcd

or:
	iverilog -o sim/or_sim rtl/func_regs.v tb/or_tb.v
	vvp sim/or_sim

wave_or:
	gtkwave sim/or_reg.vcd

control:
	iverilog -Irtl -o sim/control_sim rtl/control.v tb/control_tb.v
	vvp sim/control_sim

wave_control:
	gtkwave sim/control.vcd

proc:
	iverilog -g2012 -Irtl -o sim/proc_sim rtl/*.v tb/proc_tb.v

test1: proc
	vvp sim/proc_sim +hexfile=programs/test1.hex

test2:
	vvp sim/proc_sim +hexfile=programs/test2.hex

test3:
	vvp sim/proc_sim +hexfile=programs/test3.hex +test3

wave:
	gtkwave sim/processor.vcd