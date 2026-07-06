# Asynchronous FIFO Design using Verilog

## About the Project

This project is an implementation of an Asynchronous FIFO using Verilog HDL. The main objective was to understand how data can be transferred safely between two different clock domains.

Unlike a synchronous FIFO, the read and write operations in an asynchronous FIFO work with independent clocks. To avoid metastability issues, Gray code pointers and two-stage synchronizers are used.

The design was developed in Vivado and verified using a custom Verilog testbench.

---

## Features

- Separate read and write clocks
- Independent read and write operations
- Gray code pointer synchronization
- Two flip-flop synchronizers for CDC
- FIFO Full detection
- FIFO Empty detection
- Parameterized design
- Fully synthesizable RTL
- Functionally verified in simulation

---

## Project Files

| File | Description |
|------|-------------|
| async_fifo.v | Top module |
| fifo_mem.v | FIFO memory implementation |
| sync_ptr.v | Pointer synchronizer |
| wptr_full.v | Write pointer and Full logic |
| rptr_empty.v | Read pointer and Empty logic |
| async_fifo_tb.v | Testbench |

---

## Design Parameters

- Data Width : 8 bits
- Address Width : 4 bits
- FIFO Depth : 16 entries

---

## Verification

The following cases were verified during simulation.

- Reset operation
- Multiple write operations
- Multiple read operations
- FIFO Full condition
- FIFO Empty condition
- Pointer wrap-around
- Different read and write clock frequencies

Simulation completed successfully without any functional mismatches.

---

## Simulation Results

Waveform:

*(Add your waveform screenshot here.)*

RTL Schematic:

*(Add your RTL schematic screenshot here.)*

---

## What I Learned

Working on this project helped me understand:

- FIFO architecture
- Gray code counters
- Clock Domain Crossing (CDC)
- Two flip-flop synchronizers
- Full and Empty flag generation
- Pointer synchronization
- RTL design and verification
- Debugging using Vivado simulator

---

## Tools Used

- Verilog HDL
- Xilinx Vivado 2023.2
- Git
- GitHub

---

## Future Improvements

Some features that can be added in the future:

- Almost Full flag
- Almost Empty flag
- SystemVerilog Assertions (SVA)
- UVM-based verification

---

## Author

**Ravindar Penchala**

GitHub: https://github.com/Ravindar2401
