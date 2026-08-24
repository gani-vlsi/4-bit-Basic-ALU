# Basic 4-bit ALU with Status Flags

## Project Overview

This project implements a **Basic 4-bit Arithmetic Logic Unit (ALU)** using **Verilog HDL**. An ALU is one of the fundamental building blocks of a digital processor and is responsible for performing arithmetic and logical operations on binary data.

The ALU accepts two 4-bit input operands, `A` and `B`, along with a 3-bit selection signal `SEL` that determines the operation to be performed. The design supports **eight arithmetic and logical operations**: ADD, SUBTRACT, AND, OR, XOR, NOT, INCREMENT, and DECREMENT.

In addition to the 4-bit result, the ALU generates four important **status flags**: Carry, Overflow, Zero, and Negative. These flags provide additional information about the result and are commonly used in processor datapaths and control logic.

This project is designed as a **beginner-friendly RTL/VLSI project** to demonstrate digital logic design, combinational circuits, Verilog HDL, status flag generation, simulation, and functional verification.

---

## Objectives

The main objectives of this project are:

* To understand the internal working of an Arithmetic Logic Unit.
* To design a 4-bit combinational ALU using Verilog HDL.
* To implement eight arithmetic and logical operations.
* To understand the use of control/select signals.
* To implement Increment and Decrement operations.
* To generate Carry, Overflow, Zero, and Negative status flags.
* To write synthesizable RTL code.
* To develop a Verilog testbench for functional verification.
* To simulate the design using Icarus Verilog.
* To analyze simulation waveforms using GTKWave.
* To understand the basic RTL design and verification flow used in VLSI.

---

## ALU Inputs and Outputs

### Inputs

| Signal | Width | Description                             |
| ------ | ----: | --------------------------------------- |
| `A`    | 4-bit | First input operand                     |
| `B`    | 4-bit | Second input operand                    |
| `SEL`  | 3-bit | Selects one of the eight ALU operations |

### Outputs

| Signal     | Width | Description                                            |
| ---------- | ----: | ------------------------------------------------------ |
| `Y`        | 4-bit | Result of the selected operation                       |
| `CARRY`    | 1-bit | Indicates carry generated during arithmetic operations |
| `OVERFLOW` | 1-bit | Indicates signed arithmetic overflow                   |
| `ZERO`     | 1-bit | Indicates that the result is zero                      |
| `NEGATIVE` | 1-bit | Indicates a negative result based on the MSB           |

---

## Supported Operations

The ALU supports eight operations selected using the `SEL[2:0]` control signal.

| `SEL` | Operation | Function |
| ----- | --------- | -------- |
| `000` | ADD       | `A + B`  |
| `001` | SUBTRACT  | `A - B`  |
| `010` | AND       | `A & B`  |
| `011` | OR        | `A \| B` |
| `100` | XOR       | `A ^ B`  |
| `101` | NOT       | `~A`     |
| `110` | INCREMENT | `A + 1`  |
| `111` | DECREMENT | `A - 1`  |

### Operation Description

**ADD:** Adds the two 4-bit operands.

```text
Y = A + B
```

**SUBTRACT:** Subtracts `B` from `A`.

```text
Y = A - B
```

**AND:** Performs bitwise AND operation.

```text
Y = A & B
```

**OR:** Performs bitwise OR operation.

```text
Y = A | B
```

**XOR:** Performs bitwise Exclusive-OR operation.

```text
Y = A ^ B
```

**NOT:** Performs bitwise inversion of input `A`.

```text
Y = ~A
```

**INCREMENT:** Increases the value of `A` by one.

```text
Y = A + 1
```

**DECREMENT:** Decreases the value of `A` by one.

```text
Y = A - 1
```

---

## Basic Architecture

The overall architecture of the ALU is:

```text
                         BASIC 4-BIT ALU

       A[3:0] ───────────────┐
                             │
       B[3:0] ───────────────┤
                             ▼
                     ┌─────────────────┐
                     │                 │
       SEL[2:0] ────►│    4-BIT ALU    │
                     │                 │
                     │ ADD             │
                     │ SUBTRACT        │
                     │ AND             │
                     │ OR              │
                     │ XOR             │
                     │ NOT             │
                     │ INCREMENT       │
                     │ DECREMENT       │
                     │                 │
                     └────────┬────────┘
                              │
                  ┌───────────┼────────────┐
                  │           │            │
                  ▼           ▼            ▼
               Y[3:0]      CARRY       OVERFLOW
                             
                             
                  ┌───────────┬────────────┐
                  │                        │
                  ▼                        ▼
                ZERO                    NEGATIVE
```

The `SEL[2:0]` signal selects one of the eight operations. The selected operation generates the 4-bit result `Y`, while additional logic generates the status flags.

---

## Status Flags

The ALU generates four status flags that provide additional information about the result.

### Carry Flag

The `CARRY` flag indicates that an arithmetic operation generated a carry beyond the 4-bit result.

Example:

```text
  1111
+ 0001
------
1 0000
↑
Carry = 1
```

The 4-bit result is:

```text
Y = 0000
CARRY = 1
```

The carry flag is particularly important for unsigned arithmetic.

---

### Overflow Flag

The `OVERFLOW` flag indicates that the result of a signed arithmetic operation cannot be represented within the 4-bit signed range.

For a 4-bit signed number, the representable range is:

```text
-8 to +7
```

Overflow can occur when adding two numbers with the same sign produces a result with the opposite sign, or when subtraction produces an invalid signed result.

---

### Zero Flag

The `ZERO` flag becomes `1` when the ALU result is zero.

```text
Y = 0000
```

Therefore:

```text
ZERO = 1
```

For any non-zero result:

```text
ZERO = 0
```

---

### Negative Flag

The `NEGATIVE` flag indicates whether the result is negative when interpreted as a signed 4-bit two's-complement number.

It can be determined from the most significant bit:

```text
NEGATIVE = Y[3]
```

For example:

```text
Y = 1010
```

Since the MSB is `1`:

```text
NEGATIVE = 1
```

---

## How the ALU Works

The ALU receives two 4-bit inputs:

```text
A[3:0]
B[3:0]
```

The operation is selected using:

```text
SEL[2:0]
```

For example:

```text
A = 0101
B = 0011
SEL = 000
```

Since `SEL = 000` represents ADD:

```text
  0101
+ 0011
------
  1000
```

Therefore:

```text
Y = 1000
```

If `SEL` is changed to `010`, the ALU performs AND:

```text
  0101
& 0011
------
  0001
```

Therefore:

```text
Y = 0001
```

Similarly, the remaining `SEL` values select the other operations.

The operation selection can be implemented using a combinational `case` statement in Verilog.

---

## Increment and Decrement Operations

A specific feature of this ALU is the inclusion of **Increment and Decrement operations**.

### Increment

When:

```text
SEL = 110
```

the ALU performs:

```text
Y = A + 1
```

Example:

```text
A = 0101

0101 + 0001
-----------
0110
```

Therefore:

```text
Y = 0110
```

### Decrement

When:

```text
SEL = 111
```

the ALU performs:

```text
Y = A - 1
```

Example:

```text
A = 0101

0101 - 0001
-----------
0100
```

Therefore:

```text
Y = 0100
```

These operations demonstrate how arithmetic functionality can be extended beyond simple addition and subtraction.

---

## RTL Design

The ALU is designed as a **combinational RTL circuit**. Since the output depends only on the current inputs and select signal, no clock is required.

The basic design flow is:

```text
A, B, SEL
   │
   ▼
Operation Selection
   │
   ▼
Selected Arithmetic / Logic Operation
   │
   ├────► Y
   ├────► CARRY
   ├────► OVERFLOW
   ├────► ZERO
   └────► NEGATIVE
```

The design can be implemented using Verilog `always @(*)` and a `case` statement.

---

## Project Structure

```text
Basic-4bit-ALU/
│
├── alu.v
├── alu_tb.v
├── README.md
└── waveform.vcd
```

### File Description

**`alu.v`**

Contains the main RTL implementation of the 4-bit ALU and status flag logic.

**`alu_tb.v`**

Contains the Verilog testbench used to apply different inputs and verify the ALU operations and status flags.

**`README.md`**

Contains project documentation, architecture, operation details, simulation instructions, and verification information.

**`waveform.vcd`**

Contains the simulation waveform data generated by the testbench and can be viewed using GTKWave.

---

## Verification

A dedicated Verilog testbench is used to verify all eight ALU operations.

The testbench applies different combinations of:

* `A`
* `B`
* `SEL`

and checks:

* `Y`
* `CARRY`
* `OVERFLOW`
* `ZERO`
* `NEGATIVE`

### Example Test Cases

#### ADD

```text
A = 0101
B = 0011
SEL = 000

Expected:
Y = 1000
```

#### SUBTRACT

```text
A = 0101
B = 0011
SEL = 001

Expected:
Y = 0010
```

#### AND

```text
A = 0101
B = 0011
SEL = 010

Expected:
Y = 0001
```

#### OR

```text
A = 0101
B = 0011
SEL = 011

Expected:
Y = 0111
```

#### XOR

```text
A = 0101
B = 0011
SEL = 100

Expected:
Y = 0110
```

#### NOT

```text
A = 0101
SEL = 101

Expected:
Y = 1010
```

#### INCREMENT

```text
A = 0101
SEL = 110

Expected:
Y = 0110
```

#### DECREMENT

```text
A = 0101
SEL = 111

Expected:
Y = 0100
```

The testbench can also test boundary conditions such as:

```text
1111 + 0001
0000 - 0001
0111 + 0001
1000 - 0001
```

These cases are useful for verifying Carry, Overflow, Zero, and Negative flags.

---

## Simulation

The design can be simulated using **Icarus Verilog**.

### Compile

```bash
iverilog -o alu_sim alu.v alu_tb.v
```

### Run Simulation

```bash
vvp alu_sim
```

If the testbench generates a VCD waveform file:

```bash
gtkwave waveform.vcd
```

GTKWave can then be used to observe the relationship between:

```text
A
B
SEL
Y
CARRY
OVERFLOW
ZERO
NEGATIVE
```

---

## Simulation Flow

```text
       RTL Design
           ↓
      Write Testbench
           ↓
   Icarus Verilog Compile
           ↓
       Run Simulation
           ↓
      Generate VCD
           ↓
        GTKWave
           ↓
   Analyze Waveforms
           ↓
   Functional Verification
```

This represents a basic **RTL design and verification workflow**.

---

## Technologies Used

* **Verilog HDL** – RTL design
* **Icarus Verilog** – Compilation and simulation
* **GTKWave** – Waveform analysis
* **Linux** – Development environment
* **Git** – Version control
* **GitHub** – Project repository and documentation

---

## Key Concepts Demonstrated

This project demonstrates practical understanding of:

* Combinational logic
* Arithmetic operations
* Logic operations
* ALU architecture
* Control/select signals
* Increment and decrement operations
* Status flag generation
* Carry detection
* Signed overflow detection
* Zero detection
* Negative result detection
* Verilog `always @(*)`
* Verilog `case` statements
* RTL design
* Testbench development
* Functional verification
* VCD waveform generation
* GTKWave analysis
* Git and GitHub workflow

---

## Future Improvements

This basic 4-bit ALU can be extended into a more advanced processor-oriented design.

Possible future improvements include:

* Expanding the ALU to 8-bit, 16-bit, or 32-bit.
* Adding comparison operations.
* Adding multiplication and division.
* Adding more arithmetic operations.
* Adding configurable shift operations.
* Developing a separate Arithmetic Logic Unit architecture.
* Creating a more comprehensive verification environment.
* Adding automated assertions.
* Developing a constrained-random testbench.
* Performing RTL synthesis.
* Analyzing area, timing, and power.
* Integrating the ALU into a simple CPU datapath.

---

## Learning Outcome

Through this project, I developed a practical understanding of how a **4-bit ALU can be designed using Verilog HDL and verified through simulation**.

The project helped me understand the complete beginner-level RTL workflow:

**Specification → Architecture → RTL Coding → Testbench → Compilation → Simulation → Waveform Analysis → Functional Verification**

It also provided practical experience with status flags such as **Carry, Overflow, Zero, and Negative**, which are important components of processor and digital system design.

This project serves as a foundation for developing more advanced **RTL, VLSI, processor, and digital design projects**.

---

## Author

**UPPALA LAKSHMIGANESH**

Electronics and Communication Engineering

**Areas of Interest:** Digital Design, Verilog HDL, RTL Design, VLSI, and Computer Architecture.

