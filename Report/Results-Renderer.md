# Results

## Renderer

The VGA module must receive as an input the desired color for the current pixel of each pulse of the pixel clock. The Renderer module is given the position of each game object, and uses that information to tell the VGA module what color to make the current pixel. The following code is an example of how a game object is handled by the renderer.

```v
// draw ball
if ( screenY <= ballY
& screenY > ballY - ballHeight
& screenX >= ballX
& screenX < ballX + ballWidth )
    ballPixel <= blue;
else
    ballPixel <= black;
```

After each game object is considered, the output pixel can be determined. If two objects overlap a given pixel, their colors will be combined. If there is no object at a pixel, the output pixel is assigned the background color.

```v
// Put all objects on this pixeltogether
finalPixel <= paddlePixel |ballPixel | brickPixel;
// Apply background color wherethere are no objects
if ( finalPixel == black )
    currentPixel <= backgroundColor;
else
    currentPixel <= finalPixel;
```

