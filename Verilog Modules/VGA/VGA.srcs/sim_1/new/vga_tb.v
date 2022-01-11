`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2021 10:00:40 PM
// Design Name: 
// Module Name: vga_tb
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


module vga_tb();

reg clk = 0;
reg [2:0] currentPixel = 3'b111;
wire Hsync; wire Vsync; wire red; wire blue; wire green; wire frameSync; wire isOnScreen;
 wire [15:0] screenX; wire [15:0] screenY;

vga u0(
    .pixelClock     (clk),
    .currentPixel   (currentPixel),
    .RED            (red),
    .GREEN          (green),
    .BLUE           (blue),
    .HSYNC          (Hsync),
    .VSYNC          (Vsync),
    .frameSync      (frameSync),
    .isOnScreen     (isOnScreen),
    .screenX        (screenX),
    .screenY        (screenY)
    );
    
always #5 clk = ~clk;

endmodule
