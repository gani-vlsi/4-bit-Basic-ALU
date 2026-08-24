# 4-bit-Basic-ALU
A basic 4-bit Arithmetic Logic Unit designed and verified using Verilog.

4-bit Basic ALU
===============

Operations:
• ADD
• SUB
• AND
• OR
• XOR
• NOT
• Increment
• Decrement

Tools:
• Verilog HDL
• Icarus Verilog
• GTKWave
• Linux

Architecture
------------

A[3:0] ─────┐
             │
B[3:0] ─────┤──> 4-bit ALU ───> Y[3:0]
             │
OP[2:0] ────┘

Simulation
----------

iverilog -o alu_sim alu4.v tb_alu4.v
vvp alu_sim
gtkwave alu.vcd

Results
-------

All 8 ALU operations were verified using
Icarus Verilog and GTKWave.
