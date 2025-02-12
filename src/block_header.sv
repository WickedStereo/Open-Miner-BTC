`timescale 1ns/1ps
// -----------------------------------------------------------------------------
// Module: block_header
// Description:
//   Constructs an 80-byte (640-bit) Bitcoin block header by concatenating 
//   fixed fields with a dynamic nonce. The fields include the version, the previous
//   block hash, the Merkle root, timestamp, and difficulty bits.
// Inputs:
//   - nonce: A 32-bit dynamic value from the nonce counter.
// Outputs:
//   - header: A 640-bit block header to be hashed.
// -----------------------------------------------------------------------------
module block_header (
    input  logic [31:0]  nonce,
    output logic [639:0] header
);
  // Fixed header fields (example/sample values)
  localparam logic [31:0]   version     = 32'h20000000; // Bitcoin version number.
  localparam logic [255:0]  prev_hash   = 256'h0000000000000000000abcdef1234567890abcdef1234567890abcdef12345678; // Previous block hash.
  localparam logic [255:0]  merkle_root = 256'habcdefabcdefabcdefabcdefabcdefabcdefabcdefabcdefabcdefabcdefabc;   // Dummy Merkle root.
  localparam logic [31:0]   timestamp   = 32'h5F5B8D80; // Example timestamp (Unix epoch seconds).
  localparam logic [31:0]   bits        = 32'h17148edf; // Difficulty target bits.
  
  // Assemble the complete block header:
  // Order: version, prev_hash, merkle_root, timestamp, bits, nonce.
  assign header = { version, prev_hash, merkle_root, timestamp, bits, nonce };
endmodule
