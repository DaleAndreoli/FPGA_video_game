`timescale 1ns / 1ps

module vga_top(
    input clk,
    
    output vgaRed,
    output vgaGreen,
    output vgaBlue,
    output Hsync,
    output Vsync
    );
    
wire pixelClock;

reg [2:0] currentPixel = 3'b111;

wire frameSync; wire isOnScreen;
wire [15:0] screenX; wire [15:0] screenY;

vga_pll VGA_PLL (
.clk_in1(clk), 
.clk_out1(pixelClock)
);    
    
vga u1 (
.pixelClock(pixelClock),
.currentPixel(currentPixel),
.RED(vgaRed),
.GREEN(vgaGreen),
.BLUE(vgaBlue),
.HSYNC(Hsync),
.VSYNC(Vsync),
.frameSync(frameSync),
.isOnScreen(isOnScreen),
.screenX(screenX),
.screenY(screenY)
);

endmodule