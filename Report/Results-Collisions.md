[Back to Welcome Page](../README.md)

# Results

## Collisions

The collision detector module determines if the ball has hit another object. It takes as inputs the position of the various game objects. It compares their positions to see if they are colliding, then sends that information out as outputs. The collision logic is pretty straightforward:

```v
// Ball / Paddle Left
if ( ballY + ballHeight > paddleY +ballVelY 
& ballX + ( ballWidth / 2 ) >= paddleX
& ballX + ( ballWidth / 2 ) <= paddleX+ (paddleWidth / 3) )
    colBallPadLeft <= 1;
else
    colBallPadLeft <= 0;
```

[Next Page](Results-Sound.md)

[Back to Welcome Page](../README.md)