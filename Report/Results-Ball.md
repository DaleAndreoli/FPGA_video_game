# Results

## Ball

The ball moves around the screen bounces off the other objects. This module holds the ball’s position, speed and direction values. It takes collision values as inputs, then handles the collision by changing the ball’s position, direction and/or speed. It gives the ball’s new position and speed values as outputs. The following code shows how the ball handles some potential collisions:

```v
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
```

An important feature that improves playability of the game is that the if the ball hits the left side of the paddle, it will move toward the left. Same goes for the right side making the ball move toward the right. This gives the player a lot more control and can partly be seen in the following collision handling event:

```v
// Ball hits paddle Left
else if ( colBallPadLeft )
begin
    yDirection <= up;
    xDirection <= left;
    velX <= 15'd3;
end
```