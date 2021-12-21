`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/17/2021 07:21:15 PM
// Design Name: 
// Module Name: collisionHandler
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


module collisionHandler(
    input pixelClock,   
    input frameSync,
    
    input paddleX,
    
    input ballX,
    input ballY,
    input ballVelX,
    input ballVelY,
        
    output reg colBallLeft = 0,  
    output reg colBallRight = 0, 
    output reg colBallTop = 0,   
    output reg colBallBot = 0,   
    output reg colBallPaddle = 0    
    );
endmodule
