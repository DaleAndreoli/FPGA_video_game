`timescale 1ns / 1ps

module vga(
    input pixelClock,
    input [2:0] currentPixel,
    
    output reg RED,
    output reg GREEN,
    output reg BLUE,
    output reg HSYNC,
    output reg VSYNC,
    
    output reg frameSync,
    output reg isOnScreen,
    output reg [15:0] screenX,
    output reg [15:0] screenY
    );

reg [15:0] hPos = 0;
reg [15:0] vPos = 0;

localparam [15:0] hActivePixels = 1920;
localparam [7:0] hFrontPorch = 88;
localparam [7:0] hBackPorch = 148;
localparam [7:0] hSyncWidth = 44;
localparam [15:0] hTotalPixels = 2200;

localparam [15:0] vActiveLines = 1080;
localparam [7:0] vFrontPorch = 4;
localparam [7:0] vBackPorch = 36;
localparam [7:0] vSyncWidth = 5;
localparam [15:0] vTotalLines = 1125;

always @ ( posedge pixelClock )
begin
    // Iterate across each pixel of the screen
    hPos <= hPos + 1'b1;        // Iterate across a horizontal row.
    
    if ( hPos >= hTotalPixels ) // At the end of the horizontal row
    begin
        hPos <= 0;              // go back to the start of the horizontal
        vPos <= vPos + 1'b1;    // but iterate to the next vertical column
        
        if ( vPos >= vTotalLines ) // until we have iterated across all the vertical columns.
            vPos <= 0;
    end
    
    // Draw on the active pixels
    if  ( ( vPos >= vBackPorch )
        & ( vPos < vBackPorch + vActiveLines )
        & ( hPos >= hBackPorch )
        & ( hPos < hBackPorch + hActivePixels ) )
        begin
            isOnScreen <= 1;    // Returns True while in the active pixels
            
            RED <= currentPixel[2];
            GREEN <= currentPixel[1];
            BLUE <= currentPixel[0];
        end
    // Draw black on the porches    
    else
        begin
            isOnScreen <= 0;
            
            RED <= 0;
            GREEN <= 0;
            BLUE <= 0;
        end
    
    if ( hPos < hTotalPixels - hSyncWidth )
        HSYNC <= 1;
    else
        HSYNC <= 0;
    
    if ( vPos < vTotalLines - vSyncWidth )
        VSYNC <= 1;
    else
        VSYNC <= 0;
    
    // frameSync goes true for one pixel clock pulse per frame    
    if ( vPos == (vTotalLines - vSyncWidth) 
       & hPos == 0 )
       frameSync <= 1;
    else
       frameSync <= 0;
    // x and y coordinates on the active region   
    screenX <= hPos - hBackPorch;
    screenY <= vPos - vBackPorch;
       
end

endmodule
