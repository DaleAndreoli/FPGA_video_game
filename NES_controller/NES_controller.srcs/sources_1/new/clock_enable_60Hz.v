module clock_enable_60Hz(
    input clk,
    output reg enable
);

reg [25:0] count;

always @ ( posedge clk )
begin
    if ( count >= 100000000 / 60 )
        begin
            enable <= 1;
            count <= 0;
        end
    else
        begin
            enable <= 0;
            count <= count + 1'b1;
        end
end

endmodule