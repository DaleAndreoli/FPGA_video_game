`timescale 1ns / 1ps

module ball(
    input pixelClock,
    input frameSync,
    input colBallLeft,
    input colBallRight,
    input colBallTop,
    input colBallBot,
    input colBallPadLeft,
    input colBallPadCent,
    input colBallPadRight,
    input colBallBrick,
    
    output reg [15:0] x,
    output reg [15:0] y,
    output reg [15:0] velX,
    output reg [15:0] velY
    );
    
parameter
    width = 15'd40,
    height = 15'd40,
    screenMaxX = 15'd1920,
    screenMaxY = 15'd1080,
    maxVelY = 15'd20,
    left = 1'b0,
    right = 1'b1,
    up = 1'b0,
    down = 1'b1;
    
initial x = ( 15'd1920 / 15'd2 ) - ( width / 15'd2 );   // start at center of screen
//initial y = ( 15'd1080 / 15'd2 ) - ( height / 15'd2 );
initial y = 0;

initial velX = 15'd0;
initial velY = 15'd6;

reg xDirection = 1'b1; // 0: negative (left) 1: positive (right)
reg yDirection = 1'b1; // 0: negative (up)   1: positive (down)

always @ ( posedge pixelClock )
begin
    if ( frameSync )
    begin
        
        // Handle Collisions: Ball moving Right
        if ( xDirection == right )
        begin
            // Ball hits right edge
            if ( colBallRight ) 
                xDirection <= left;    // ball changes direction to Left
                
            // No Collisions    
            else                
            begin
                if ( x + velX < screenMaxX - width )  // move right but not past edge
                    x <= x + velX;                                                  
                else                                                                
                    x <= screenMaxX - width;                                           
            end
        end
        
        // Handle Collisions: Ball moving Left
        else
        begin
            // Ball hits left edge
            if ( colBallLeft )
                xDirection <= right;    // ball changes direction to Right
                
            // No Collisions
            else
            begin
                if ( x > velX )     // move left but not past edge
                    x <= x - velX;
                else
                    x <= 0;
            end
        end
        
        // Handle Collisions: Ball moving Down
        if ( yDirection == down )
        begin
            // Ball hits Bottom edge
            if ( colBallBot )
                yDirection <= up;
                
            // Ball hits paddle Left
            else if ( colBallPadLeft )
            begin
                yDirection <= up;
                xDirection <= left;
                velX <= 15'd3;
            end
                
            // Ball hits paddle Center
            else if ( colBallPadCent )
            begin
                yDirection <= up;
                velX <= 15'd0;
            end
                
            // Ball hits paddle Right
            else if ( colBallPadRight )
            begin
                yDirection <= up;
                xDirection <= right;
                velX <= 15'd3;
            end
                
            // Ball Hits Brick
            else if ( colBallBrick )
            begin
                yDirection <= up;
                xDirection <= ~xDirection;
                velX <= 15'd6;
                if ( velY < maxVelY )
                    velY <= velY + 3;
            end
                
            // No Collisions
            else
            begin
                if ( y + velY < screenMaxY ) // move down but not past edge
                    y <= y + velY;
                else
                    y <= screenMaxY;
            end
        end
        
        // Handle Collisions: Ball moving Up
        else
        begin
            // Ball hits Top edge
            if ( colBallTop )
            begin
                yDirection <= down;
                velX <= 15'd4;
            end
                
            // Ball Hits Brick
            else if ( colBallBrick )
            begin
                yDirection <= down;
                xDirection <= ~xDirection;
                velX <= 15'd6;
                if ( velY < maxVelY )
                    velY <= velY + 2;
            end
                
            // No Collisions
            else
            begin
                if ( y > velY ) // move up but not past edge
                    y <= y - velY;
                else 
                    y <= 0;
            end
        end
    end
end

endmodule
