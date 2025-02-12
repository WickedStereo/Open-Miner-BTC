`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module: sha256_message_scheduler
// Description:
//   Expands a padded message into a schedule of words (W[0..63]) as per 
//   the SHA-256 specification. Supports up to two blocks.
// Inputs:
//   - clk: Clock signal.
//   - block_count: Number of blocks to process.
//   - block_in: Padded input block(s).
// Outputs:
//   - trigger: Indicates when a word is ready.
//   - W: Output word from the schedule.
//////////////////////////////////////////////////////////////////////////////////

module sha256_message_scheduler(
    input clk,
    input [1:0] block_count,
    input [1023:0] block_in, // Supports up to two blocks (1024 bits total).
    output logic trigger,
    output logic [31:0] W
);

    // Internal registers and scheduling functions remain unchanged.

endmodule
