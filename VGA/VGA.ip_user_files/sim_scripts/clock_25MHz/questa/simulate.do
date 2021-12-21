onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib clock_25MHz_opt

do {wave.do}

view wave
view structure
view signals

do {clock_25MHz.udo}

run -all

quit -force
