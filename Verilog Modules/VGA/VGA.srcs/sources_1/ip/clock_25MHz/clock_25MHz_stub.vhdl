-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
-- Date        : Wed Nov 24 21:56:04 2021
-- Host        : Dales-Desktop running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub {e:/Documents/School/ECEN
--               397/FGPA_video_game/VGA/VGA.srcs/sources_1/ip/clock_25MHz/clock_25MHz_stub.vhdl}
-- Design      : clock_25MHz
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a35tcpg236-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clock_25MHz is
  Port ( 
    clk_out1 : out STD_LOGIC;
    clk_in1 : in STD_LOGIC
  );

end clock_25MHz;

architecture stub of clock_25MHz is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk_out1,clk_in1";
begin
end;
