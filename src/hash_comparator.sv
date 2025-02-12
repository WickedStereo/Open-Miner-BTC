`timescale 1ns/1ps
// -----------------------------------------------------------------------------
// Module: hash_comparator
// Description:
//   Compares the computed 256-bit hash against a provided target value.
//   A valid solution is indicated when the hash is less than the target.
// Inputs:
//   - hash: The 256-bit output from the double SHA-256 computation.
//   - target: The 256-bit target threshold.
// Outputs:
//   - valid_solution: Asserted high if (hash < target); otherwise low.
// -----------------------------------------------------------------------------
module hash_comparator (
    input  logic [255:0] hash,
    input  logic [255:0] target,
    output logic       valid_solution
);
  always_comb begin
    // Check if the computed hash is below the target threshold.
    if (hash < target)
      valid_solution = 1'b1;
    else
      valid_solution = 1'b0;
  end
endmodule
