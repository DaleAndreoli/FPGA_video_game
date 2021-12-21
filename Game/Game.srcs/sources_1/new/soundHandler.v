`timescale 1ns / 1ps

module soundHandler(
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
    
    output reg soundOut = 0
    );
    
reg [15:0] durationFrames = 0;

always @ ( posedge pixelClock )
begin
    if ( frameSync )
    begin
        if ( durationFrames == 0 )
        begin
            soundOut <= 0;
            if ( colBallBrick | colBallPadLeft | colBallPadCent | colBallPadRight )
            begin
                soundOut <= 1;
                durationFrames <= 12;
            end
        end
        else
            durationFrames <= durationFrames - 1'b1;
    end
end
    
endmodule
