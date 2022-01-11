`timescale 1ns / 1ps

module collisionDetector(
    input pixelClock,   
    input frameSync,
    
    input [15:0] paddleX,
    
    input [15:0] ballX,
    input [15:0] ballY,
    input [15:0] ballVelX,
    input [15:0] ballVelY,
        
    output reg colBallLeft = 0,  
    output reg colBallRight = 0, 
    output reg colBallTop = 0,   
    output reg colBallBot = 0,   
    output reg colBallPadLeft = 0,
    output reg colBallPadCent = 0,
    output reg colBallPadRight = 0,
    output reg colBallBrick = 0,
    output reg [31:0] aliveBricks = 32'hffffffff    
    );
    
parameter
    ballHeight =  15'd40,
    ballWidth = 15'd40,
    paddleY = 15'd1020,
    paddleWidth = 15'd300,
    screenMaxX = 15'd1920,
    screenMaxY = 15'd1080,
    brickX = 15'd175,
    brickY = 15'd200,
    brickWidth = 15'd100,
    brickHeight = 15'd50,
    brickVertSpace = 15'd90,
    brickHorzSpace = 15'd210,
    dead = 1'b0;
 
reg [15:0] brick;   
    
always @ ( posedge pixelClock )
begin
    if ( frameSync )
    begin
        // Ball / Bricks
        colBallBrick <= 0;
        for ( brick = 15'd0; brick < 15'd32; brick = brick + 1'b1 )
            if ( aliveBricks[brick]
            & ballY >= brickY + ( (brick / 8) * brickVertSpace )
            & ballY <= brickY + brickHeight + ( (brick / 8) * brickVertSpace )
            & ballX + ( ballWidth / 2 ) >= brickX + ( (brick % 8) * brickHorzSpace )
            & ballX + ( ballWidth / 2 ) <= brickX + brickWidth + ( (brick % 8) * brickHorzSpace ) )
            begin
                aliveBricks[brick] <= dead;
                colBallBrick <= 1;
            end 
            
        // Ball / Screen Left
        if ( ballX == 0 )
            colBallLeft <= 1;
        else 
            colBallLeft <= 0;
        
        // Ball / Screen Right
        if ( ballX + ballWidth >= screenMaxX )
            colBallRight <= 1;
        else
            colBallRight <= 0;
            
        // Ball / Screen Top
        if ( ballY <= ballHeight + 5 ) 
            colBallTop <= 1;
        else
            colBallTop <= 0;
       
        // Ball / Screen Bottom
        if ( ballY >= screenMaxY )
            colBallBot <= 1;
        else
            colBallBot <= 0;
            
        // Ball / Paddle Left
        if ( ballY + ballHeight > paddleY + ballVelY 
        & ballX + ( ballWidth / 2 ) >= paddleX
        & ballX + ( ballWidth / 2 ) <= paddleX + (paddleWidth / 3) )
            colBallPadLeft <= 1;
        else
            colBallPadLeft <= 0;   
            
        // Ball / Paddle Center
        if ( ballY + ballHeight > paddleY + ballVelY 
        & ballX + ( ballWidth / 2 ) >= paddleX + (paddleWidth / 3)
        & ballX + ( ballWidth / 2 ) <= paddleX + (paddleWidth * 2 / 3) )
            colBallPadCent <= 1;
        else
            colBallPadCent <= 0;  
                     
        // Ball / Paddle Right
        if ( ballY + ballHeight > paddleY + ballVelY 
        & ballX + ( ballWidth / 2 ) > paddleX + (paddleWidth * 2 / 3)
        & ballX + ( ballWidth / 2 ) <= paddleX + paddleWidth )
            colBallPadRight <= 1;
        else
            colBallPadRight <= 0;
    end
end

endmodule
