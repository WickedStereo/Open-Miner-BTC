`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module: sha256_core_pipe
// Description:
//   Implements a pipelined SHA-256 core. Processes one block at a time and 
//   outputs a single-round hash.
// Inputs:
//   - clk, reset: Clock and reset signals.
//   - block_count: Number of blocks to process.
//   - W: Input word from the scheduler.
//   - H_in: Initial hash value (H0).
// Outputs:
//   - H_out: Final hash value after processing one block.
//   - trigger: Indicates when processing is complete.
//////////////////////////////////////////////////////////////////////////////////

module sha256_core_pipe (
    input logic clk,
    input logic reset,    
    input logic [1:0] block_count,
    input logic [31:0] W,
    input logic [255:0] H_in,
    output logic [255:0] H_out,
    output logic trigger
);

    // State machine parameters and internal registers remain unchanged.

endmodule
