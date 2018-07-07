# cpuHamada

This simulation was modeled after *Ben Eater*'s 8-bit processor and is written entirely in Verilog
and is meant to be simulated in Modelsim.
This processor has very limited capabilities but does what it does well.

This was part of a project issued by prof. Al-Habrouk, Faculty of Engineering, Alexandria University.

I had to learn Verilog and write up this code in the span of 4 days. The code isn't perfect but I'm
proud of what I'd accomplished.

What follows is a detailed description of what every module is and what it does.

## memory Module

* The memory module is responsible for saving the output or the ALU and assigning it
to the appropriate memory address.
* It contains an array of 16 registers each 8-bit wide which forms the core of the memory.
* This module acts as the de facto control unit which our project here lacks for the purpose
of simplicity.

##### memory Module has three inputs, ramInput, instr and clk and one output, ramOut.
* *instr*: receives the instruction code from the user.
* *ramOut*: passes the instruction through to the ALU.
* *ramInput*: receives the output from the ALU after being processed.

## clk Module

* Very straight forward, simply generates an oscillating wave.

## alu Module

* This effectively the processing unit of the design, it spits solutions when fed with instructions.

##### The alu has 3 inputs, a, b and instr
* a and b are arbitrary 8-bit inputs entered by the user.
* instr is the instruction entered by the user which is previously tunneled through the memory module.
* The alu sends its output to the memory module where it's then added to the theoritical RAM there.

I've since added flags to the alu.

##### Current working flags are carry and compare flags
* *carryFlag*: turns one when there's a carry to addition (say adding 0xFF to 0x01).
* *compFlag*: turns one when input a < b, this comes in handy for two's complement.

## cpu Module

* This module simply wires all the previous modules together.

## Instructions Table

* 0x0x - Loads the value of input 'a' and assigns it to memory address x
* 0x1x - Loads the value of input 'b' and assigns it to memory address x
* 0x2x - Adds 'a' and 'b' and assigns the output to memory address x
* 0x3x - Subtracts 'a' by 'b' and assigns the output to memory address x
* 0x4x - Multiplies 'a' by 'b' and assigns the output to memory address x
* 0x5x - Divides 'a' by 'b' and assigns the output to memory address x
* 0x6x - Shifts 'a' left by 'b' and assigns the output to memory address x
* 0x7x - Shifts 'a' right by 'b' and assigns the output to memory address x

All the modules have the prefix 'alt' because this was created as an alternate project
and ended up as the main project but I kept the names to avoid confusion.
