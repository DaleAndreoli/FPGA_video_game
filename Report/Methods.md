[Back to Welcome Page](../README.md)
# Methods and Procedure

This project uses a Basys 3 Artix-7 FPGA to handle input, output and game logic. This FPGA has an on-board VGA output. The video was output to a computer monitor at 1080p resolution at 60Hz refresh rate. The audio was output from a buzzer that makes a beep when given a high signal from one of the Pmod headers on the FPGA. The game is controlled by a Nintendo Entertainment System controller which connects to several of the Pmod headers on the FPGA to send button input data. Game logic is handled by hardware designed in Verilog then programmed on to the FPGA.

## Video Output

I did some research into other video output methods such as HDMI and DVI. They would have been possible but HDMI was a bit more complicated to implement than VGA. DVI also was less convenient since my FPGA already has a VGA out connector built in.

Implementing this component was aided by documentation of timing values for this output specification. Understanding the function of a pixel clock and the various sync regions used in VGA output was necessary to get this component working. A testbench for this module was invaluable as I had to debug several errors along the way. Research, development and debugging for the video output component took about 14 hours. My plan to test the VGA module was to assign each pixel a color (they all had to be the same color since I did not have a rendering module yet). I could then hook the device to my monitor and verify that it was outputting the proper color.

## Audio Output

There were many options I found in my research for handling audio output. My favorite was a little soundboard that you can upload audio files onto then send a signal to various pins on the board to select a sound to be played. I couldn’t get my hands on one for this project, but it would be a cool upgrade to make in the future.

I went with a buzzer that makes a beep when sent a signal. I would have liked something more versatile, but this is what I already had in my parts drawer. Research and testing for the audio module only took about 7 hours total. To test this module, my plan was to send the buzzer a signal and verify that it made a beep.

## Controller Input

I researched a few different controllers that would have worked for this project. Most of them used USB, which would have worked just fine. I went with the NES controller that had a lot of documentation and seemed very straightforward. It also went with the retro feel of a more primitive style of video game.

The NES controller sends all of its button values through a single data pin, which can be read with the help of a clock signal and latch signal that go into the controller. This required research to get the proper timing for the signals (bertiusgames). An official vintage NES controller actually requires 5 V to operate, where my FPGA has mostly 3.3 V pins. Fortunately, my controller is a modern off brand that supports 3.3 V operating voltage. Research and testing for the controller input took around 13 hours. My test plan for the controller was to assign each button value to a built-in LED on the FPGA. Then I could press each button and make sure the proper LED activates.

## Game Design

The remainder of the project was to bring each of the hardware components together and design the game. I looked to simple games of the past as I researched a viable game to design for this project. The game I settled on is a variant of Brick Break. The player controls a paddle that moves along the bottom edge of the screen. The player must move the paddle to hit a ball that bounces around the screen. An array of bricks is laid out. When the ball collides with a brick, the brick is destroyed and the ball bounces away. If the player misses the ball, the player loses and game is over. If all the bricks are destroyed, the player wins and the game is over.

As planned, this phase of the project took by far the most time. Combining all the hardware modules while designing the game logic led to a lot of debugging and troubleshooting. Some features needed to be added to the VGA module to fit in with the rest of the project. Drawing shapes on the screen and handling collisions had a lot of room for error and debugging. Designing, developing and debugging the game was done over the course of several weeks and took around 70 hours. The test plan for the project as a whole is to program the FPGA and make sure the game plays as designed.

[Next Page](Results.md)

[Back to Welcome Page](../README.md)