`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module: top_sha256_pipe
// Description:
//   Top-level module for single-round SHA-256 hashing. It processes a full 
//   80-byte (640-bit) Bitcoin block header and computes the SHA-256 hash.
//   This module supports multi-block padding and integrates the message scheduler 
//   and pipelined SHA-256 core.
// Parameters:
//   - MSG_BITS: Input message size in bits (default is 640 for Bitcoin block header).
//   - PADDED_BITS: Padded message size in bits (default is 512 for a single block).
//////////////////////////////////////////////////////////////////////////////////

module top_sha256_pipe #(parameter MSG_BITS = 640, parameter PADDED_BITS = 512) 
(
    input logic clk,
    input logic reset,
    input logic [MSG_BITS-1:0] message, // Full block header (80 bytes).
    output logic trigger,               // Trigger signal for pipeline completion.
    output logic [255:0] H_out          // Final hash output.
);

    // Wires
    logic [PADDED_BITS-1:0] padded_message; 
    logic [1:0] block_count;             // Supports up to 2 blocks.
    logic done;
    logic [31:0] W_in;
    reg [31:0] W_in_delay;
    logic [255:0] H;

    // Initial Hash Values (H0)
    localparam logic [255:0] H0 = 256'h6a09e667bb67ae8583ef5b5a3c6ef372a54ff53a510e527fade682d1cbbb9d5d;

    // Instantiate the message padder
    sha256_message_padder #(
        .MSG_BITS(MSG_BITS),
        .PADDED_BITS(PADDED_BITS)
    ) mypadder (
        .message(message),
        .block_count(block_count),
        .padded_message(padded_message)
    );

    // Instantiate the message scheduler
    sha256_message_scheduler myscheduler (
        .clk(clk),
        .block_count(block_count),
        .block_in(padded_message),
        .trigger(trigger),
        .W(W_in)
    );

    // Delay W_in by one clock cycle for pipeline alignment
    always_ff @(posedge clk) W_in_delay <= W_in;

    // Instantiate the pipelined SHA-256 core
    sha256_core_pipe mypipe (
        .clk(clk),
        .reset(reset),
        .block_count(block_count),
        .W(W_in_delay),
        .H_in(H0),
        .H_out(H),
        .trigger(done)  
    );

    // Assign final hash output
    assign H_out = H;

endmodule
