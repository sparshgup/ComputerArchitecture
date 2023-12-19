SHELL=/bin/bash
IVERILOG=iverilog -g2012 -Wall -Wno-sensitivity-entire-vector -Wno-sensitivity-entire-array -y./ -y./tests -Y.sv -I./ -DSIMULATION
VVP=vvp
VVP_POST=-fst
# Comment out after --rcvar on lower res screens.
WAVES=gtkwave #--rcvar 'fontname_signals Monospace 20' --rcvar 'fontname_waves Monospace 20'

.PHONY: clean

clean:
	rm -f *.bin *.vcd *.fst vivado*.log *.jou vivado*.str *.log *.checkpoint *.bit *.html *.xml *.out
	rm -rf .Xil

#########################################################################
## RV32 Core
#########################################################################

## Register File
RFILE_SRCS = register_file.sv register.sv decoder*.sv mux*.sv

## ALU
ALU_SRCS = alu.sv alu_types.sv adder_1.sv adder_n.sv comparator_eq.sv comparator_lt.sv mux*.sv sll.sv srl.sv sra.sv

## rv32i
RV32I_SRCS = rv32i_multicycle_core.sv rv32_common.sv ${RFILE_SRCS} ${ALU_SRCS} 

## Assembler (assembles .s files into .memh files)
%.memh : %.s ../tools/assembler.py ../tools/rv32i.py
	../tools/assembler.py $< -o $@

## rv32i simulator
rv32_simulator: ${RV32I_SRCS} tests/rv32_simulator.sv
	${IVERILOG} -y ./rv32 $^ -s $@ -o $@

## rv32i waveforms
waves_rv32: rv32_simulator
	${WAVES} -a tests/rv32.gtkw  rv32_simulator.fst

#########################################################################
# Instruction Type Tests
#########################################################################

test_rv32_itypes: rv32_simulator ../asm/itypes.memh
	./rv32_simulator +initial_memory=../asm/itypes.memh ${VVP_POST}

test_rv32_irtypes: rv32_simulator ../asm/irtypes.memh
	./rv32_simulator +initial_memory=../asm/irtypes.memh ${VVP_POST}

test_rv32_btypes: rv32_simulator ../asm/btypes.memh
	./rv32_simulator +initial_memory=../asm/btypes.memh ${VVP_POST}

test_rv32_jtypes: rv32_simulator ../asm/jtypes.memh
	./rv32_simulator +max_cycles=1000 +initial_memory=../asm/jtypes.memh ${VVP_POST}

test_rv32_lstypes: rv32_simulator ../asm/lstypes.memh
	./rv32_simulator +max_cycles=100 +initial_memory=../asm/lstypes.memh ${VVP_POST}

test_rv32_utypes: rv32_simulator ../asm/utypes.memh
	./rv32_simulator +max_cycles=25 +initial_memory=../asm/utypes.memh ${VVP_POST}