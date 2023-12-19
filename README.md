# Computer Architecture

Sparsh Gupta

This repository has SystemVerilog implementations of computer architecture components using primarily structural combinational and some behavioral logic.

It also has implementations for RISC-V CPU and FPGA USB-UART communication.

## List of components

- 1-bit adder
- N-bit adder 
- N-bit adder (carry look ahead)
- N-bit adder (prefix)
- Equal comparator
- Less than comparator
- Decoders
- Muxes
- Shifters (SLL, SRL, SRA)
- ALU (capable of performing operations AND, OR, XOR, Addition, Subtraction, SLL, SRL, SRA, SLT, SLTU, w/ overflow)
- Register
- Pulse Generator
- PWM (Pulse Width Modulator)
- Edge Detector
- Triangle Generator

## RISC-V CPU

This implementation of the RISC-V CPU rv32i (integer subset of RISC-V spec) system with a multicycle core.

Learn more about it on the [rv32i - README]([https://github.com/sparshgup/ComputerArchitecture/](https://github.com/sparshgup/ComputerArchitecture/blob/main/rv32i/README.md)) in this repo.

The instructions compatible with this implementation:

- **R-type**: add, sub, xor, or, and, sll, srl, sra, slt, sltu
- **I-type**: addi, xori, ori, andi, slli, srli, srai, slti, sltiu
- **Memory-Type**: lw, sw, lb, sb, lh, sh, lbu, shu
- **B-type**: beq, bne, blt, bltu, bge, bgeu
- **J-type**: jal, jalr
- **U-type**: lui, auipc

## FPGA USB-UART communication

The UART implementation utilizes the [Cmod A7 FPGA Reference](https://digilent.com/reference/programmable-logic/cmod-a7/reference-manual) FPGA to simulate.

The universal asynchronous receiver/transmitter (UART) driver consists of the FSM logic for transmitting and receiving data. 

The system has an RX (receive) channel that can receive characters. If it receives the characters 'r,' 'g,' or 'b' (in either case), it will change the color of the tricolor LED to match. The system also has a TX (transmit) channel that lets us print any desired string with an FSM.
