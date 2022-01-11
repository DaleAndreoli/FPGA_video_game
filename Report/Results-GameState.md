# Results

## Game State

The game state module determines if the game is over, and passes that information to the renderer. If the game is over, the renderer will display a red screen or a green screen depending on whether the player lost or won the game. The game state module takes the ball/screen bottom collision signal as an input, as well as the alive status of the bricks. If the ball hit the bottom of the screen, it sends a “game over – lost” signal. If all the bricks are destroyed, it sends a “game over – won” signal.

```v
if ( colBallBot & gameState == stillPlaying )
    gameState <= gameLost;
else if ( aliveBricks == 32'd0 & gameState == stillPlaying )
    gameState <= gameWon;
```