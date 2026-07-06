# Async FIFO Design using Verilog HDL

## Project Overview

This project implements an **Asynchronous FIFO (First-In First-Out)** using **Verilog HDL**. The design safely transfers data between two different clock domains using **Gray code pointer synchronization**, making it suitable for Clock Domain Crossing (CDC) applications.

The project is fully synthesizable and functionally verified using a Verilog testbench in Vivado.

---

## Features

- Dual Clock Asynchronous FIFO
- Independent Read and Write Clocks
- Gray Code Pointer Synchronization
- Two Flip-Flop Synchronizers
- Full Flag Generation
- Empty Flag Generation
- Parameterized FIFO Depth
- Synthesizable RTL
- Functional Verification using Testbench

---

## FIFO Architecture

```
                +-----------------------+
                |     Async FIFO        |
                |                       |
Write Clock --->|                       |---> Read Clock
Write Enable -->|                       |---> Read Enable
Write Data ---->|      FIFO Memory      |---> Read Data
                |                       |
                | Gray Pointer Sync     |
                | Full / Empty Logic    |
                +-----------------------+
```

---

## RTL Modules

### async_fifo.v
Top module that instantiates all FIFO submodules.

### fifo_mem.v
Implements the FIFO memory array used to store data.

### sync_ptr.v
Implements two-stage synchronizers for safe pointer synchronization across clock domains.

### wptr_full.v
Generates the write pointer and detects FIFO Full condition.

### rptr_empty.v
Generates the read pointer and detects FIFO Empty condition.

### async_fifo_tb.v
Functional verification testbench.

---

## Design Parameters

| Parameter | Value |
|-----------|------|
| Data Width | 8 bits |
| Address Width | 4 bits |
| FIFO Depth | 16 Entries |
| Write Clock | Independent |
| Read Clock | Independent |

---

## Functional Verification

The design has been verified for:

- FIFO Reset
- Multiple Writes
- Multiple Reads
- Full Condition
- Empty Condition
- Simultaneous Read/Write
- Pointer Wrap-around
- Clock Domain Crossing

Simulation completed successfully without functional errors.

---

## Simulation Waveform

> Add your waveform screenshot here.

Example:

```
docs/waveform.png
```

---

## RTL Schematic

> Add your RTL schematic screenshot here.

Example:

```
docs/rtl_schematic.png
```

---

## Tools Used

- Verilog HDL
- Xilinx Vivado 2023.2
- Git
- GitHub

---

## Future Improvements

- Almost Full Flag
- Almost Empty Flag
- Programmable FIFO Depth
- SystemVerilog Assertions (SVA)
- UVM Verification
- Formal Verification

---

## Learning Outcomes

Through this project I gained hands-on experience in:

- RTL Design
- Asynchronous FIFO Architecture
- FIFO Memory Design
- Gray Code Counters
- Pointer Synchronization
- Clock Domain Crossing (CDC)
- Functional Verification
- Git & GitHub Workflow

---

## Repository Structure

```
async_fifo_design/
│
├── async_fifo.v
├── fifo_mem.v
├── sync_ptr.v
├── rptr_empty.v
├── wptr_full.v
├── async_fifo_tb.v
├── README.md
└── docs/
    ├── waveform.png
    └── rtl_schematic.png
```

---

## Author

**Ravindar Penchala**

GitHub:
https://github.com/Ravindar2401

---

If you found this project useful, feel free to ⭐ the repository.
