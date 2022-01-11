[Back to Welcome Page](../README.md)

# Results

## Sound

The sound module receives information from the collision handler, which allows it to determine when a signal should be sent to the buzzer to make a beep.

```v
soundOut <= 0;
if ( colBallBrick | colBallPadLeft | colBallPadCent | colBallPadRight )
begin
    soundOut <= 1;
    durationFrames <= 12;
end
```

[Next Page](Results-Bricks.md)

[Back to Welcome Page](../README.md)