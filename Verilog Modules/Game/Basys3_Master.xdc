# Clock signal
set_property PACKAGE_PIN W5 [get_ports clk]							
	set_property IOSTANDARD LVCMOS33 [get_ports clk]
	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]

##Pmod Header JA
#Sch name = JA1
set_property PACKAGE_PIN J1 [get_ports {controllerData}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {controllerData}]
#Sch name = JA2
set_property PACKAGE_PIN L2 [get_ports {latch}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {latch}]
#Sch name = JA3
set_property PACKAGE_PIN J2 [get_ports {pulse}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {pulse}]

##Pmod Header JB
#Sch name = JB1
set_property PACKAGE_PIN A14 [get_ports {soundOut}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {soundOut}]

#VGA Connector
set_property PACKAGE_PIN N19 [get_ports {vgaRed}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {vgaRed}]
set_property PACKAGE_PIN J18 [get_ports {vgaBlue}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {vgaBlue}]
set_property PACKAGE_PIN D17 [get_ports {vgaGreen}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {vgaGreen}]
set_property PACKAGE_PIN P19 [get_ports Hsync]						
	set_property IOSTANDARD LVCMOS33 [get_ports Hsync]
set_property PACKAGE_PIN R19 [get_ports Vsync]						
	set_property IOSTANDARD LVCMOS33 [get_ports Vsync]