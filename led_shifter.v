module LedShifter #(
    parameter CLK_FREQ = 25_000_000 
) (
    input  wire clk,
    input  wire rst_n,
    output  reg [7:0] leds
);

    // contador de ciclos para gerar pulso de deslocamento
    reg [31:0] cycle_count;
    localparam integer CYCLES = CLK_FREQ / 4;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            cycle_count <= 32'd0;
            leds <= 8'h1F;        // valor inicial após reset
        end else begin
            if (cycle_count == CYCLES - 1) begin
                cycle_count <= 32'd0;
                leds <= { leds[6:0], leds[7] };
            end else begin
                cycle_count <= cycle_count + 32'd1;
            end
        end
    end
    
endmodule
