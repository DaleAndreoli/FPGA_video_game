`timescale 1ns / 1ps

module Game(
    input clk,
    
    output soundOut,
    
    input controllerData,
    output latch,
    output pulse,
    
    output vgaRed,
    output vgaGreen,
    output vgaBlue,
    output Hsync,
    output Vsync
    );

wire pixelClock; wire [2:0] currentPixel; wire frameSync; wire isOnScreen;
wire [7:0] buttons;
wire activateSound;
wire [15:0] screenX; wire [15:0] screenY;
wire [15:0] paddleX; wire [15:0] ballX; wire [15:0] ballY; wire [7:0] ballVelX; wire [7:0] ballVelY;
wire colBallLeft; wire colBallRight; wire colBallTop; wire colBallBot; 
wire colBallPadLeft; wire colBallPadCent; wire colBallPadRight; wire colBallBrick;
wire [31:0] aliveBricks; wire [1:0] gameState;

gamestateDetector Gamestate (
    .pixelClock     (pixelClock),
    .frameSync      (frameSync),   
    .colBallBot     (colBallBot),
    .aliveBricks    (aliveBricks),
    
    .gameState      (gameState)
);

soundHandler Sound (
    .pixelClock     (pixelClock),
    .frameSync      (frameSync),   
    .colBallLeft    (colBallLeft),
    .colBallRight   (colBallRight),
    .colBallTop     (colBallTop),
    .colBallBot     (colBallBot),
    .colBallPadLeft (colBallPadLeft),
    .colBallPadCent (colBallPadCent),
    .colBallPadRight(colBallPadRight),
    .soundOut       (soundOut)
);

collisionDetector Collisions (
    .pixelClock     (pixelClock),
    .frameSync      (frameSync),   
    .paddleX        (paddleX),   
    .ballX          (ballX),     
    .ballY          (ballY),     
    .ballVelX       (ballVelX),  
    .ballVelY       (ballVelY), 
    
    .colBallLeft    (colBallLeft),
    .colBallRight   (colBallRight),
    .colBallTop     (colBallTop),
    .colBallBot     (colBallBot),
    .colBallPadLeft (colBallPadLeft),
    .colBallPadCent (colBallPadCent),
    .colBallPadRight(colBallPadRight),
    .colBallBrick   (colBallBrick),
    .aliveBricks    (aliveBricks)         
);

ball Ball (
    .pixelClock     (pixelClock),    
    .frameSync      (frameSync),     
    .colBallLeft    (colBallLeft),   
    .colBallRight   (colBallRight),  
    .colBallTop     (colBallTop),    
    .colBallBot     (colBallBot),    
    .colBallPadLeft (colBallPadLeft),
    .colBallPadCent (colBallPadCent),
    .colBallPadRight(colBallPadRight),
    .colBallBrick   (colBallBrick),
    
    .x              (ballX),
    .y              (ballY),
    .velX           (ballVelX),
    .velY           (ballVelY) 
);

renderer Renderer (
    .pixelClock     (pixelClock),
    .isOnScreen     (isOnScreen),
    .screenX        (screenX),
    .screenY        (screenY),
    .paddleX        (paddleX),
    .ballX          (ballX),
    .ballY          (ballY),
    .aliveBricks    (aliveBricks),
    .gameState      (gameState),
    
    .currentPixel   (currentPixel)  
);

paddle Paddle (
    .pixelClock     (pixelClock),
    .frameSync      (frameSync),
    .buttons        (buttons),
    
    .x              (paddleX)
);

nes_controller Controller (
    .clk            (pixelClock),
    .data           (controllerData),
    
    .latch          (latch),
    .pulse          (pulse),
    .buttons        (buttons)
);

vga VGA (
    .pixelClock     (pixelClock),
    .currentPixel   (currentPixel),
    
    .RED            (vgaRed),
    .GREEN          (vgaGreen),
    .BLUE           (vgaBlue),
    .HSYNC          (Hsync),
    .VSYNC          (Vsync),
    .frameSync      (frameSync),
    .isOnScreen     (isOnScreen),
    .screenX        (screenX),
    .screenY        (screenY)
);

VGA_PLL vga_pll (
    .clk_in1        (clk),
     
    .clk_out1       (pixelClock)
);
    
endmodule
