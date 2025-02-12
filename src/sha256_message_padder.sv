`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module: sha256_message_padder
// Description:
//   Pads an input message according to the SHA-256 specification. Supports 
//   multi-block padding for messages larger than 512 bits.
// Parameters:
//   - MSG_BITS: Size of the input message in bits.
//   - PADDED_BITS: Size of each padded block in bits (default is 512).
//////////////////////////////////////////////////////////////////////////////////

module sha256_message_padder #(
  parameter MSG_BITS = 640,
  parameter PADDED_BITS = 512
) 
(
  input logic [MSG_BITS-1:0] message,
  output logic [1:0] block_count,               // Number of blocks after padding.
  output logic [(2*PADDED_BITS)-1:0] padded_message // Padded message (supports up to 2 blocks).
);

  localparam ZERO_BITS = PADDED_BITS - (MSG_BITS % PADDED_BITS) - 65;

  logic [(2*PADDED_BITS)-1:0] padded_message_reg;

  always_comb begin
      padded_message_reg = '0;
      padded_message_reg[MSG_BITS-1:0] = message;       // Copy original message.
      padded_message_reg[MSG_BITS] = 1'b1;             // Append '1' bit.
      padded_message_reg[(2*PADDED_BITS)-65 +: 64] = MSG_BITS; // Append length in bits.
      block_count = (MSG_BITS + ZERO_BITS + 65 > PADDED_BITS) ? 2 : 1; // Calculate block count.
  end

  assign padded_message = padded_message_reg;

endmodule
