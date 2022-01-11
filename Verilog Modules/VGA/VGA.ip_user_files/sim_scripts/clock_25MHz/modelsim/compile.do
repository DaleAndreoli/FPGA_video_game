vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xil_defaultlib

vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vlog -work xil_defaultlib -64 -incr "+incdir+../../../ipstatic" \
"../../../../VGA.srcs/sources_1/ip/clock_25MHz/clock_25MHz_clk_wiz.v" \
"../../../../VGA.srcs/sources_1/ip/clock_25MHz/clock_25MHz.v" \


vlog -work xil_defaultlib \
"glbl.v"

