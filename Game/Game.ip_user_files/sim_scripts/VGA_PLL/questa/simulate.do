onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib VGA_PLL_opt

do {wave.do}

view wave
view structure
view signals

do {VGA_PLL.udo}

run -all

quit -force
