# Open-Miner-BTC

This repository contains the RTL implementation of the Open Miner BTC, a Bitcoin mining ASIC, in SystemVerilog. The design integrates a double SHA-256 encryption IP block with modules for block header generation, nonce iteration, and hash comparison. The goal is to eventually implement the design as an ASIC with a USB interface to enable direct communication with CGMiner.

## Project Overview

The current RTL design includes the following key modules:
- **Double SHA-256 IP Block:** Performs the required double SHA-256 encryption.
- **Block Header Generator:** Constructs the 80-byte block header by concatenating fixed Bitcoin block fields (version, previous hash, Merkle root, timestamp, and difficulty bits) with a dynamic nonce.
- **Nonce Counter:** A simple counter that iteratively generates a new nonce value for each hashing attempt.
- **Hash Comparator:** Compares the computed hash against a supplied target value, flagging a valid solution when the hash is below the target.
- **CGMiner Integration Module:** Interfaces with external mining software by providing the computed hash, nonce, and solution status. The final ASIC version is planned to use a USB interface for this purpose.

## Current Progress

- **RTL Completed:**  
  - The core RTL for the double SHA‑256 IP block is integrated with the block header generator, nonce counter, and hash comparator.
  - Basic top-level integration modules are provided for standalone operation.
  
## Future Work

- **Verification Environment:**  
  Develop a comprehensive testbench and simulation environment to rigorously verify the RTL design. This will include both functional and timing verification to ensure that the design meets all design specifications.
  
- **ASIC Implementation:**  
  Following successful verification, the next phase is to transition the design to an ASIC. This will involve:
  - Implementing a USB interface for direct connection with CGMiner,
  - Completing the necessary physical design and fabrication flow,
  - Ensuring the ASIC meets power and thermal requirements.

### Architecture Extension

In the next phase of this project, the design will be extended by adding multiple parallel SHA-256 blocks. This extension aims to achieve increased throughput by processing multiple nonces simultaneously.

#### Key Considerations:
- **Parallelization:**  
  It is proposed to start with 8–16 parallel SHA-256 blocks for an initial prototype. This number can scale based on synthesis results, power consumption, and thermal constraints.
  
- **Target Comparison Strategy:**  
  Two possible approaches are being evaluated:
  - **Centralized Comparator:**  
    All SHA-256 blocks would store their output hashes, and a single comparator would sequentially compare each hash against the target. This reduces area overhead but could introduce latency.
  - **Distributed Comparators:**  
    Integrating a dedicated comparator within each SHA-256 block allows for parallel, independent comparisons, eliminating sequential bottlenecks at the expense of increased area and power consumption.
  
The current recommendation is to pursue the distributed comparator approach. This allows each SHA-256 engine to independently and immediately signal when a valid hash (i.e., hash < target) is found. This architecture will maximize throughput and reduce delay, making the design highly scalable and efficient.

*Note:* The code for the parallel architecture will be developed in a later phase. At this time, the core modules and independent miner top module provide a solid foundation for future expansion.

### Integration with Host Software

The standalone design can later be integrated with mining software (e.g., CGMiner) by instantiating the entire mining block as a single IP. This integration is planned for subsequent development once the ASIC implementation and its verification environment are completed.


## Getting Started

### Prerequisites

- A SystemVerilog simulator (e.g., ModelSim, VCS, or similar) for simulation and verification.
- Synthesis tools for prototyping on FPGA (optional) before moving to an ASIC implementation.
- Open-source ASIC design flows (e.g., OpenROAD) for physical design, if applicable.

### Repository Structure

- **src/**  
  Contains the SystemVerilog RTL design files for the core modules.
  
- **testbench/**  
  (Upcoming) Testbench files and simulation scripts to verify functionality and timing.
  
- **docs/**  
  Documentation and design notes related to the project.

### Simulation

Once the verification environment is established, simulations can be run using your preferred SystemVerilog simulator to validate both functionality and performance of the design.

## Contributing

Contributions and suggestions are welcome. Please consider opening an issue or submitting a pull request for enhancements, bug fixes, or additional features.

## License

This project is licensed under the GNU GPL-3 License.

## Acknowledgments

Thanks to the open-source community and all the contributors who have provided support and inspiration in creating this Bitcoin mining ASIC design.
