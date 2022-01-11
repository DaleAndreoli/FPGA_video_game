vlib work
vlib activehdl

vlib activehdl/xil_defaultlib

vmap xil_defaultlib activehdl/xil_defaultlib

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../ipstatic" \
"../../../../VGA.srcs/sources_1/ip/clock_25MHz/clock_25MHz_clk_wiz.v" \
"../../../../VGA.srcs/sources_1/ip/clock_25MHz/clock_25MHz.v" \


vlog -work xil_defaultlib \
"glbl.v"

