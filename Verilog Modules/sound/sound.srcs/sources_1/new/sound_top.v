`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/19/2021 04:29:54 PM
// Design Name: 
// Module Name: sound_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module sound_top(
    input clk,
    input btnR,
    
    output reg JA
    );

wire buzzer;

assign buzzer = JA;

sound u1 (
.clk(clk),
.activate(btnR),
.buzzer(buzzer)
);
    
endmodule
