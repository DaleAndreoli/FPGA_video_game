`timescale 1ns / 1ps

module renderer(
    input pixelClock,
    input isOnScreen,
    input [15:0] screenX,
    input [15:0] screenY,
    
    input [15:0] paddleX,
    
    input [15:0] ballX,
    input [15:0] ballY,
    
    input [31:0] aliveBricks,
    input [1:0] gameState,
    
    output reg [2:0] currentPixel
    );
    
localparam
	black = 3'b000,
	blue = 3'b001,
	green = 3'b010,
	cyan = 3'b011,
	red = 3'b100,
	magenta = 3'b101,
	yellow = 3'b110,
	grey = 3'b111;
	
reg [2:0] gameOverColor = grey;
reg [2:0] backgroundColor = cyan;

reg [2:0] paddlePixel;
reg [2:0] ballPixel;
reg [2:0] brickPixel;

reg [2:0] finalPixel;

parameter 
    paddleY = 15'd1020,
    paddleHeight = 15'd30,
    paddleWidth = 15'd300,
    ballHeight = 15'd40,
    ballWidth = 15'd40,
    brickX = 15'd175,
    brickY = 15'd200,
    brickWidth = 15'd100,
    brickHeight = 15'd50,
    brickVertSpace = 15'd90,
    brickHorzSpace = 15'd210,
    stillPlaying = 2'b00,
    gameLost = 2'b01,
    gameWon = 2'b10;
    
    
reg [15:0] brick;

always @ ( posedge pixelClock )
begin
    if ( isOnScreen )
    begin
        if ( gameState == stillPlaying )
        begin
            // Draw Bricks
            brickPixel <= black;
            for ( brick = 15'd0; brick < 15'd32; brick = brick + 1'b1 )
                if ( aliveBricks[brick]
                & screenY <= brickY + ( (brick / 8) * brickVertSpace )
                & screenY > brickY - brickHeight + ( (brick / 8) * brickVertSpace )
                & screenX >= brickX + ( (brick % 8) * brickHorzSpace )
                & screenX < brickX + brickWidth + ( (brick % 8) * brickHorzSpace ) )
                    brickPixel <= magenta;
            
            // draw paddle
            if ( screenY <= paddleY       
            & screenY > paddleY - paddleHeight   
            & screenX >= paddleX
            & screenX < paddleX + paddleWidth )   
                paddlePixel = red;
            else
                paddlePixel = black;
                
            // draw ball
            if ( screenY <= ballY
            & screenY > ballY - ballHeight
            & screenX >= ballX
            & screenX < ballX + ballWidth )
                ballPixel <= blue;
            else
                ballPixel <= black;
            
            // Put all objects on this pixel together
            finalPixel <= paddlePixel | ballPixel | brickPixel;
            // Apply background color where there are no objects
            if ( finalPixel == black )
                currentPixel <= backgroundColor;
            else
                currentPixel <= finalPixel;
        end
        
        else if ( gameState == gameWon )
            currentPixel <= green;
        else if ( gameState == gameLost )
            currentPixel <= red;
    end
end    
endmodule