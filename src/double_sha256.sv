`timescale 1ns/1ps
//////////////////////////////////////////////////////////////////////////////////
// Module: double_sha
// Description:
//   Implements the double SHA-256 algorithm by instantiating two rounds of
//   the SHA-256 pipeline. The first instance processes the full Bitcoin block
//   header (80 bytes / 640 bits) using a multi-block padder. Its 256-bit output
//   is then used as the input for the second instance, which processes the inner
//   hash (256 bits) after padding it into a single 512-bit block.
// Parameters:
//   The first round uses MSG_BITS = 640 (full header) and the second round uses
//   MSG_BITS = 256. PADDED_BITS is set to 512 in both cases.
// Inputs:
//   - clk: Clock signal.
//   - reset: Asynchronous reset signal.
//   - message: Full 80-byte Bitcoin block header.
// Outputs:
//   - trigger: Asserted when the double SHA-256 operation has completed.
//   - hash_out: Final 256-bit double SHA-256 computed hash.
//////////////////////////////////////////////////////////////////////////////////

module double_sha256 (
    input  logic         clk,
    input  logic         reset,
    input  logic [639:0] message,    // Full block header (80 bytes)
    output logic         trigger,    // Completion flag for double SHA-256
    output logic [255:0] hash_out    // Final double SHA-256 hash
);

    // Wires for inter-module connection.
    logic         inner_trigger;   // Trigger from the first round
    logic [255:0] inner_hash;      // 256-bit intermediate hash from round one
    logic         outer_trigger;   // Trigger from the second round

    // First SHA-256 round: Process the full block header.
    // The multi-block padder will produce 2 blocks since 640 bits require padding
    // into 1024 bits (2 * 512).
    sha256pipetop #(
        .MSG_BITS(640),
        .PADDED_BITS(512)
    ) sha256round1 (
        .clk(clk),
        .reset(reset),
        .message(message),
        .trigger(inner_trigger),
        .H_out(inner_hash)
    );
    
    // Second SHA-256 round: Process the 256-bit inner hash.
    // The inner hash is padded as a 256-bit message, which fits in one block.
    sha256pipetop #(
        .MSG_BITS(256),
        .PADDED_BITS(512)
    ) sha256round2 (
        .clk(clk),
        .reset(reset),
        .message(inner_hash),
        .trigger(outer_trigger),
        .H_out(hash_out)
    );
    
    // The final trigger is driven by the completion of the outer round.
    assign trigger = outer_trigger;

endmodule
