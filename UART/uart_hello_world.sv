`timescale 1ns/1ps
`default_nettype none

module uart_hello_world(clk, buttons, leds, rgb, uart_tx, uart_rx);

parameter CLK_HZ = 12_000_000;
parameter BAUDRATE = 115_200;

input wire clk;
input wire [1:0] buttons;
output logic [1:0] leds;
output logic [2:0] rgb;

input wire uart_rx;
output wire uart_tx;

logic rst; always_comb rst = buttons[0];

logic [7:0] tx_data;
wire [7:0] rx_data;
wire tx_ready, rx_valid;
logic tx_valid;


parameter ROM_L=13;
logic [$clog2(ROM_L)-1:0] rom_addr;
wire [7:0] rom_data;

block_rom #(.L(ROM_L), .W(8), .INIT("memories/uart_hello_world.memh"))
ROM(
  .clk(clk), .addr(rom_addr), .data(rom_data)
);

uart_driver #(
  .CLK_HZ(CLK_HZ),
  .BAUDRATE(BAUDRATE),
  .SYNC_DEPTH(3),
  .DATA_BITS(8),
  .PARITY(0),
  .STOP_BITS(1)
) UART (
  .clk(clk),
  .rst(rst),
  .uart_rx(uart_rx),
  .uart_tx(uart_tx),
  .rx_data(rx_data), 
  .rx_valid(rx_valid), 
  .tx_data(tx_data),
  .tx_valid(tx_valid),
  .tx_ready(tx_ready)
);


enum logic [0:0] {
  S_START,
  S_WAIT
} state;

enum logic [0:0] {
  DATA_SRC_ROM,
  DATA_SRC_LOOPBACK
} data_src;

logic [7:0] loopback_data;
always_ff @(posedge clk) begin
  if(rst) begin
    loopback_data <= 0;
  end else begin
    if(rx_valid) begin
      loopback_data <= rx_data;
    end
  end
end

always_comb begin : tx_data_mux
  case(data_src)
    DATA_SRC_LOOPBACK : tx_data = loopback_data;
    DATA_SRC_ROM      : tx_data = rom_data;
  endcase
end // tx_data_mux

wire rx_valid_posedge;
edge_detector RX_VALID_EDGE_DETECTOR (
  .clk(clk), .rst(rst), .in(rx_valid), .positive_edge(rx_valid_posedge), .negative_edge()
);

always_ff @(posedge clk) begin : main_fsm
  if(rst) begin
    state <= S_WAIT;
    data_src <= DATA_SRC_ROM;
    rom_addr <= 0;
    rgb <= 3'b111;
  end else begin
    case(state)
      S_WAIT: begin
        case(data_src)
          DATA_SRC_ROM: begin
            if(tx_ready) begin
              tx_valid <= 1;
              state <= S_START;
            end
          end
          DATA_SRC_LOOPBACK: begin
            if(rx_valid_posedge) begin
              case(rx_data)
                // These are ascii codes, mapping to R, r, G, g, B, b respectively.
                // What combinational logic could you do to make this work for upper or lower case input?
                8'd82  : rgb <= 3'b011;
                8'd114 : rgb <= 3'b011;
                8'd71  : rgb <= 3'b101;
                8'd103 : rgb <= 3'b101;
                8'd66  : rgb <= 3'b110;
                8'd98  : rgb <= 3'b110;
                default: rgb <= rgb;
              endcase
            end
            if(tx_ready & rx_valid_posedge) begin
              tx_valid <= 1;
              state <= S_START;
            end
          end
        endcase
      end
      S_START: begin
        tx_valid <= 0;
        if(data_src == DATA_SRC_ROM) begin
          if(rom_addr == (ROM_L-1)) begin
            data_src <= DATA_SRC_LOOPBACK;
          end
          rom_addr <= rom_addr + 1;
        end
        state <= S_WAIT;
      end
    endcase
  end
end // main_fsm

// Typically a UART implementation will have (buffered) LEDs connected to the tx and rx lines.
// This leads to a visible blinking whenever data is sent, and you can tell which way it is going 
// based on which LED is lit up (provided the buadrate is slow enough/there isn't too much duplex 
// traffic).
always_comb begin : classic_uart_txrx_leds
  leds[0] = ~uart_rx;
  leds[1] = ~uart_tx;
end // classic_uart_txrx_leds

endmodule // uart_hello_word
