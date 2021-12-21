`timescale 1ns / 1ps

module nes_controller_top (
    input clk,
    input data,
    output latch,
    output pulse,
    output [7:0] led
    );
    
nes_controller U1 (
.clk(clk),
.data(data),
.latch(latch),
.pulse(pulse),
.buttons(led)
);
    
endmodule