# cpuSyoufShamaa

This simulation was modeled after *Ben Eater*'s 8-bit processor and is written entirely in Verilog
and is meant to be simulated in Modelsim.
This processor has very limited capabilities but does what it does well.

This was part of a project issued by prof. Al-Habrouk, Faculty of Engineering, Alexandria University.

All the modules have the prefix 'alt' because this was created as an alternate project
and ended up as the main project but I kept the names to avoid confusion.

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
* 0x8x - jumps to the instruction in memory address x, this is only available in mode 1


## Mode System

##### Mode system gives the user the option to toggle between two mode

* *Mode zero*: The user enters the instruction directly and chooses where to save the output on the RAM as usual
* *Mode one*: The user sets up a programme into the instrMem in the memory module where a maximum of 16 operations 
could be executed in sequence.


* The instrMem has 16 memory address which is purely an arbitrary number for the sake of uniformity. The CPU currently as of July 2018 can only perform 8 operations (including loading a and b to memory addresses).
* The current build is preloaded with a programme which performs all operations and assigns them to sequential memory address in the dataMemory.

### Notes on mode system

* In mode zero, instr can be changed during simulation time.
* In mode one, input instr is completely useless and doesn't affect anything. although you'll need to fill it with random 8-bit to avoid
compilation errors.

## Simulation

##### I'm using Modelsim for simulation and currently I have no access to an actual fpga board so this I have no idea whether it'll work on an fpga or not. But I guarantee it'll work in Modelsim

* During simulation in Modelsim, you'll need to keep an eye on dataMemory where all the outputs show up.
* dataMemory is an array of registers found in the memory module.
