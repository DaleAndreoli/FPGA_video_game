[Back to Welcome Page](../README.md)

# Results

## Video Output

In order to output to VGA, specific timing requirements need to be met. The screen I used has a refresh rate of 60Hz. This means that each pixel needs to be updated 60 times per second. Since each pixel is assigned its color one at a time, a “pixel clock” is used where each pulse updates a pixel. This clock needs to be fast enough to update each pixel 60 times per second in my case. VGA timing value documentation (Green) confirms the pixel clock for 1080p@60Hz to be a clock speed of 148.5 MHz.

This clock rate is faster than the built-in clock on my FPGA is able to provide. In order to obtain a clock rate of this speed, a phase locked loop must be used. This converts the base clock speed to exactly what is needed for the pixel clock. Vivado has a clocking wizard to automatically create a PLL with the specified input and output clock speeds.

```v
//----------------------------------------------------------------------------
//  Output     Output      Phase    Duty Cycle   Pk-to-Pk     Phase
//   Clock     Freq (MHz)  (degrees)    (%)     Jitter (ps)  Error (ps)
//----------------------------------------------------------------------------
// clk_out1__148.57143______0.000______50.0______220.768____300.278
//
//----------------------------------------------------------------------------
// Input Clock   Freq (MHz)    Input Jitter (UI)
//----------------------------------------------------------------------------
// __primary_________100.000____________0.010

`timescale 1ps/1ps

(* CORE_GENERATION_INFO = "..." *) // abbreviated string

module VGA_PLL 
 (
  // Clock out ports
  output        clk_out1,
 // Clock in ports
  input         clk_in1
 );
```

With a proper pixel clock, the VGA module can be implemented. The following code iterates across each pixel of the screen with each pulse of the pixel clock.

```v
// Iterate across each pixel of the screen
hPos <= hPos + 1'b1;        // Iterateacross a horizontal row.

if ( hPos >= hTotalPixels ) // At the endof the horizontal row
begin
    hPos <= 0;              // go back to the start of the horizontal
    vPos <= vPos + 1'b1;    // but iterate to the next vertical column
    
    if ( vPos >= vTotalLines ) // until we have iterated across all the vertical columns.
        vPos <= 0;
end
```

VGA uses several different regions to help sync what is eventually displayed. The following image from the VGA documentation (Green) shows these different regions.

![vga-sync](Images/display-sync-regions.png)

The exact size of each region is different for each resolution. The following parameters used in the VGA module were established in the documentation (Green).

```v
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
```

With these parameters established, as we iterate across the display, we can draw our desired color on the current pixel if it is in the Active region.

```v
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
```

The VGA module also provides important information to other modules of the game. The frameSync signal helps other modules update once per 60Hz frame. The screenX and screenY give useful coordinates to other modules without them needing to worry about the sync regions.

```v
// frameSync goes true for one pixel clock pulse per frame    
if ( vPos == (vTotalLines - vSyncWidth) 
   & hPos == 0 )
   frameSync <= 1;
else
   frameSync <= 0;
// x and y coordinates on the activeregion   
screenX <= hPos - hBackPorch;
screenY <= vPos - vBackPorch;
```

## Video Output - Testbench

Creating a testbench was very helpful to getting the video output to work. The timing diagram made it easy to see the values of each signal and determine where things went wrong in the code.

![vga-tb](Images/vga-testbench.png)

[Next Page](Results-Renderer.md)

[Back to Welcome Page](../README.md)