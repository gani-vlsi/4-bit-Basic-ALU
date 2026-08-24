module alu4 (
    input  [3:0] A,
    input  [3:0] B,
    input  [2:0] OP,

    output reg [3:0] Y,
    output reg       Carry,
    output reg       Overflow,
    output           Zero,
    output           Negative
);

    reg [4:0] temp;

    always @(*) begin

        // Default values
        Y        = 4'b0000;
        Carry    = 1'b0;
        Overflow = 1'b0;
        temp     = 5'b00000;

        case (OP)

            // 000 : Addition
            3'b000: begin
                temp = A + B;
                Y = temp[3:0];
                Carry = temp[4];

                Overflow = (~(A[3] ^ B[3])) &
                           (Y[3] ^ A[3]);
            end

            // 001 : Subtraction
            3'b001: begin
                Y = A - B;
                Carry = (A < B);

                Overflow = (A[3] ^ B[3]) &
                           (Y[3] ^ A[3]);
            end

            // 010 : AND
            3'b010:
                Y = A & B;

            // 011 : OR
            3'b011:
                Y = A | B;

            // 100 : XOR
            3'b100:
                Y = A ^ B;

            // 101 : NOT A
            3'b101:
                Y = ~A;

            // 110 : Increment A
            3'b110: begin
                temp = A + 1'b1;
                Y = temp[3:0];
                Carry = temp[4];
            end

            // 111 : Decrement A
            3'b111: begin
                Y = A - 1'b1;
                Carry = (A == 4'b0000);
            end

        endcase
    end

    // Status flags
    assign Zero = (Y == 4'b0000);
    assign Negative = Y[3];

endmodule
