# FPGA 7-Segment Display Controller (VHDL)

## Description

This project implements a 4-digit 7-segment display controller on an FPGA using VHDL.  
The system allows user interaction through push buttons to select a digit, increment or decrement its value, and reset the display.

The design is fully modular and consists of three main blocks: input filtering, control logic, and display management.

---

## Features

- 4-digit 7-segment display multiplexing
- Button-controlled digit selection
- Increment and decrement functionality for each digit
- Global reset function
- Debouncing filter for mechanical push buttons
- Modular VHDL architecture

---

## System Architecture

The system is divided into three main modules:

### 1. Button Filter (Filtre_boutons)
This module removes mechanical bouncing from push buttons using a counter-based debounce mechanism.  
It ensures stable input signals for the rest of the system.

### 2. Control Logic (Bloc_Logique)
This module handles:
- Digit selection (left/right buttons)
- Value increment and decrement (up/down buttons)
- Reset functionality
- Storage of the four displayed digits

### 3. Display Driver (Bloc_Affichage)
This module:
- Performs multiplexing of the 4-digit display
- Converts binary values into 7-segment encoding
- Refreshes the display at a high enough frequency to avoid flickering

---

## Technical Details

- FPGA clock frequency: 100 MHz
- Language: VHDL
- Debounce implementation: counter-based stabilization
- Display refresh: multiplexed scanning of 4 digits
- Edge detection used for button inputs

---

## File Structure

src/
TOP_projet_segments.vhd
Filtre_boutons.vhd
Bloc_Logique.vhd
Bloc_Affichage.vhd

constraints/
Basys-3-Master.xdc

docs/
architecture.jpg

---

## How It Works

1. Button inputs are first stabilized by the debounce filter.
2. The control logic interprets user actions and updates the stored digits.
3. The display driver continuously multiplexes the 4 digits on the 7-segment display.

---

## Possible Improvements

- Add hexadecimal support (A–F display)
- Highlight selected digit visually
- Add UART interface for external control

---

## Hardware

- FPGA board: Basys 3 AMD Artix™ 7 FPGA Trainer Board
- 4-digit 7-segment display
- Push buttons for user input

---

## Author

FPGA project developed as part of a digital design learning process using VHDL.
Etienne Moutinho

