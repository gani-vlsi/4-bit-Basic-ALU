`timescale 1ns/1ps

module tb_alu4;

    reg [3:0] A;
    reg [3:0] B;
    reg [2:0] OP;

    wire [3:0] Y;
    wire Carry;
    wire Overflow;
    wire Zero;
    wire Negative;

    // Instantiate ALU
    alu4 dut (
        .A(A),
        .B(B),
        .OP(OP),
        .Y(Y),
        .Carry(Carry),
        .Overflow(Overflow),
        .Zero(Zero),
        .Negative(Negative)
    );

    // Generate waveform
    initial begin
        $dumpfile("alu.vcd");
        $dumpvars(0, tb_alu4);
    end

    // Test cases
    initial begin

        $monitor(
            "Time=%0t | A=%b | B=%b | OP=%b | Y=%b | Carry=%b | Overflow=%b | Zero=%b | Negative=%b",
            $time, A, B, OP, Y, Carry, Overflow, Zero, Negative
        );

        // ADD
        A = 4'b0101;
        B = 4'b0011;
        OP = 3'b000;
        #10;

        // SUB
        A = 4'b0110;
        B = 4'b0010;
        OP = 3'b001;
        #10;

        // AND
        A = 4'b1100;
        B = 4'b1010;
        OP = 3'b010;
        #10;

        // OR
        A = 4'b1100;
        B = 4'b1010;
        OP = 3'b011;
        #10;

        // XOR
        A = 4'b1100;
        B = 4'b1010;
        OP = 3'b100;
        #10;

        // NOT
        A = 4'b1010;
        B = 4'b0000;
        OP = 3'b101;
        #10;

        // INC
        A = 4'b1111;
        B = 4'b0000;
        OP = 3'b110;
        #10;

        // DEC
        A = 4'b0000;
        B = 4'b0000;
        OP = 3'b111;
        #10;

        $finish;

    end

endmodule
