`timescale 1ns/1ps
// -----------------------------------------------------------------------------
// Module: nonce_counter
// Description:
//   Implements a simple 32-bit counter that increments on each clock cycle.
//   This counter generates the dynamic nonce used in the mining process.
// Inputs:
//   - clk: Clock signal.
//   - reset: Asynchronous reset signal (active high).
// Outputs:
//   - nonce: 32-bit counter value representing the dynamic nonce.
// -----------------------------------------------------------------------------
module nonce_counter (
    input  logic        clk,
    input  logic        reset,
    output logic [31:0] nonce
);
  always_ff @(posedge clk or posedge reset) begin
    if (reset)
      nonce <= 32'd0;         // Reset the nonce to zero.
    else
      nonce <= nonce + 32'd1; // Increment the nonce on every clock cycle.
  end
endmodule
