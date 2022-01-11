`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/19/2021 06:00:20 PM
// Design Name: 
// Module Name: sound
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


module sound(
    input clk,
    input activate,
    
    output reg buzzer
    );
    
reg [25:0] count = 0;
localparam tone = 100000000 / 500;
 
always @ ( posedge clk )
begin
    count <= count + 1'b1;
    
    if ( !activate )
        count <= 0;
        
    if (count == tone)
        begin
            buzzer <= ~buzzer;
            count <= 0;
        end
end 
 
 
    
endmodule
