onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+VGA_PLL -L xpm -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.VGA_PLL xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {VGA_PLL.udo}

run -all

endsim

quit -force
