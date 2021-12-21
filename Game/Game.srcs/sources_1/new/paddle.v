`timescale 1ns / 1ps

module paddle(
    input pixelClock,
    input frameSync,
    input [7:0] buttons,
    
    output reg [15:0] x
    );
    
parameter
    width = 16'd300,
    height = 8'd30,
    screenWidth = 16'd1920,
    screenHeight = 16'd1080,
    btnLeft = 8'd6,
    btnRight = 8'd7;
    
// Paddle moves along the same Y value
parameter y = screenHeight - 16'd60;

initial x = ( screenWidth / 2 ) - ( width / 2 );

localparam [7:0] thrust = 20;

always @ ( posedge pixelClock)
begin
    if ( frameSync )
    begin
        if ( buttons[btnLeft]   // if Left button is pressed
        & x > thrust )          // and paddle is not beyond left side of screen
            x <= x - thrust;        // then move left
           
        if ( buttons[btnRight]
        & x + width < screenWidth - thrust )
            x <= x + thrust; 
    end
end    
    
endmodule
