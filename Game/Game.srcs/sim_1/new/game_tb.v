`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/17/2021 12:37:54 AM
// Design Name: 
// Module Name: game_tb
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


module game_tb();

reg clk = 0;

wire red; wire green; wire blue; wire Hsync; wire Vsync;

Game game(
.clk        (clk),
.vgaRed     (red),  
.vgaGreen   (green),
.vgaBlue    (blue), 
.Hsync  (Hsync),   
.Vsync  (Vsync)
);

always #5 clk = ~clk;
    
endmodule
