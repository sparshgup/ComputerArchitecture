# Computer Architecture

Sparsh Gupta

This repository has SystemVerilog implementations of computer architecture components using primarily structural combinational and some behavioral logic.

(In progress) It also has implementations for RISC-V CPU, Conway's Game of Life, and FPGA USB-UART communication.

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

[TODO - add rv32i files]

The instructions compatible with this implementation:

- **R-type**: add, sub, xor, or, and, sll, srl, sra, slt, sltu
- **I-type**: addi, xori, ori, andi, slli, srli, srai, slti, sltiu
- **Memory-Type**: lw, sw, lb, sb, lh, sh, lbu, shu
- **B-type**: beq, bne, blt, bltu, bge, bgeu
- **J-type**: jal, jalr
- **U-type**: lui, auipc

## Conway's Game of Life

HDL Implementation using SystemVerilog of [Conway's Game of Life](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life)

It utilizes a [Cmod A7 FPGA Reference](https://digilent.com/reference/programmable-logic/cmod-a7/reference-manual) FPGA to simulate it on an 8x8 LED display matrix. 

![IMG_5009](https://github.com/sparshgup/ComputerArchitecture/assets/19605629/baaa6a0b-e89e-4bf0-a440-b306e0e4fb35)

## FPGA USB-UART communication

The UART implementation also utilizes the [Cmod A7 FPGA Reference](https://digilent.com/reference/programmable-logic/cmod-a7/reference-manual) FPGA to simulate.

The universal asynchronous receiver/transmitter (UART) driver consists of the FSM logic for transmitting and receiving data. 

The system has an RX (receive) channel that can receive characters. If it receives the characters 'r,' 'g,' or 'b' (in either case), it will change the color of the tricolor LED to match. The system also has a TX (transmit) channel that lets us print any desired string with an FSM.
