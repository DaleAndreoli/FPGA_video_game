`timescale 1ns / 1ps

module nes_controller(
    input clk,
    input data,
    output reg latch,
    output reg pulse,
    output reg [7:0] buttons
    );

wire clockEnable;
clock_enable_60Hz U1 (
.clk(clk),
.enable(clockEnable)
);
    
parameter
    btnA = 8'd0,
    btnB = 8'd1,
    btnSel = 8'd2,
    btnStart = 8'd3,
    btnUp = 8'd4,
    btnDown = 8'd5,
    btnLeft = 8'd6,
    btnRight = 8'd7;

// Comm States    
localparam
    idle = 0,
    setLatch = 1,
    readBtn = 2;

// Latch and pulse timings    
localparam
    clockIn12us = 100000000 / 1000000 * 12,
    clockIn6us = clockIn12us / 8'd2;
    
reg [7:0] commState = idle;
reg [7:0] currentButton = btnA;
reg [15:0] count = 0;

always @ ( posedge clk )
begin
    if ( clockEnable )
        begin
            count <= 0;
            commState <= setLatch;
        end
    
    case(commState)
        setLatch:
            begin
                if (count < clockIn12us)
                    begin
                        latch <= 1;
                        count <= count + 1'b1;
                    end
                else
                    begin
                        latch <= 0;
                        count <= clockIn6us[15:0];
                        currentButton <= btnA;
                        commState <= readBtn;
                    end
            end
        readBtn:
            begin
                if ( count < clockIn6us )
                    pulse <= 1;
                else
                    pulse <= 0;
                
                if ( count == clockIn6us )
                    buttons[currentButton] <= ~data;
                    
                if ( count < clockIn12us )
                    count <= count + 1'b1;
                else
                    if ( currentButton == btnRight )
                        commState <= idle;
                    else
                        begin
                            count <= 0;
                            currentButton <= currentButton + 1'b1;
                        end
            end
        default:
            begin
                latch <= 0;
                pulse <= 0;
            end
    endcase
end
    
endmodule
