# Results

## Bricks

Since the game features an array of thirty-two bricks, the best way to implement the bricks was by using a for loop. In Verilog, for loops work a bit differently than in typical programming language. They are essentially unrolled and each iteration executes in parallel rather than looped through procedurally. They are only really useful as a shortcut to write a segment of code over and over. The bricks are implemented by the following for loops:

```v
// Draw Bricks
brickPixel <= black;
for ( brick = 15'd0; brick <15'd32; brick = brick + 1'b1 )
    if ( aliveBricks[brick]
    & screenY <= brickY + ( (brick / 8) * brickVertSpace )
    & screenY > brickY - brickHeight + ( (brick / 8) * brickVertSpace )
    & screenX >= brickX + ( (brick % 8) * brickHorzSpace )
    & screenX < brickX + brickWidth + ( (brick % 8) * brickHorzSpace ) )
        brickPixel <= magenta;
```

```v
// Ball / Bricks
colBallBrick <= 0;
for ( brick = 15'd0; brick < 15'd32;brick = brick + 1'b1 )
    if ( aliveBricks[brick]
    & ballY >= brickY + ( (brick / 8) * brickVertSpace )
    & ballY <= brickY + brickHeight + ( (brick / 8) * brickVertSpace )
    & ballX + ( ballWidth / 2 ) >= brickX + ( (brick % 8) * brickHorzSpace )
    & ballX + ( ballWidth / 2 ) <= brickX + brickWidth + ( (brick % 8) * brickHorzSpace ) )
    begin
        aliveBricks[brick] <= dead;
        colBallBrick <= 1;
    end 
```

I struggled to implement these loops that handle the bricks in their own module similar to the other game objects. I am sure it is possible, but for now they are handled entirely in the Renderer and Collision modules.