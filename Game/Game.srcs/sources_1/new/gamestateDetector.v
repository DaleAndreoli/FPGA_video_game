`timescale 1ns / 1ps

module gamestateDetector(
    input pixelClock,
    input frameSync,
    input colBallBot,
    input [31:0] aliveBricks,
    
    output reg [1:0] gameState = 2'b00
    );
    
parameter
    stillPlaying = 2'b00,
    gameLost = 2'b01,
    gameWon = 2'b10;
    
always @ ( posedge pixelClock )
begin
    if ( frameSync )
    begin
        if ( colBallBot & gameState == stillPlaying )
            gameState <= gameLost;
        else if ( aliveBricks == 32'd0 & gameState == stillPlaying )
            gameState <= gameWon;
    end
end
    
endmodule
