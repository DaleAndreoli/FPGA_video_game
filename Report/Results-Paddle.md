# Results

## Paddle

The player uses the left and right buttons to move the paddle along the bottom of the screen. The Paddle module receives the buttons values from the controller as inputs. This module holds, updates and sends the paddle’s x coordinate as an output. The following code shows how it changes the paddles x coordinate each frame according to what button is pressed.

```v
if ( frameSync )
    begin
        if ( buttons[btnLeft]   // if Left button is pressed
        & x > thrust )          // and paddle is not beyond left side of screen
            x <= x - thrust;        // then move left
           
        if ( buttons[btnRight]
        & x + width < screenWidth - thrust )
            x <= x + thrust; 
    end
```