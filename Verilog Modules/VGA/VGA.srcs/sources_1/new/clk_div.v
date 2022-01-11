`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2021 10:21:41 PM
// Design Name: 
// Module Name: clk_div
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


module clk_div(
    input clk,
    output clk_div
    );
    
parameter BIT_SEL = 2;   
    
reg [25:0] count;
initial count = 0;

always @ ( posedge clk )
count <= count + 1'b1;

assign clk_div = count[BIT_SEL];
    
endmodule
