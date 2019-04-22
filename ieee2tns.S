			;		ARM Programming Assignment #3: IEEE 754 to TNS bit-level marshaller
			;
			;		Write a program to convert a 32-bit single-precision IEEE 754 floating-point
			;		number to the Tandem Non-stop Series (TNS) format. Refer to the README for a
			;		description of the format. Convert the numbers in `floats` and write the TNS
			;		equivalents into the `tns` area, one after the other.
			;
			;		Bonus:
			;		1. (30 extra points) Implement the reverse conversion, from TNS to IEEE.
			;		2. (50 extra points) Organize the code into two subroutines, with stack
			;		support.
			;		3. (10 extra points) In the main program, implement a round-trip conversion
			;		and prove the results match the initial values in 'floats'.  Define a
			;		`FILL` region to hold the IEEE 754 results.
			;
			
			;		Your code here
			ADR		R2, floats
			ADR		R10, tns
			ADR		R11, ieee
			LDR		R0, [R2]
			LDR		R1, [R2, #4]
			MOV		R9, R0
			BL		ieeetns
			STR		R8, [R10]
			MOV		R9, R1
			BL		ieeetns
			STR		R8, [R10, #4]
			LDR		R0, [R10]
			LDR		R1, [R10, #4]
			MOV		R9, R0
			BL		tnsieee
			STR		R8, [R11]
			MOV		R9, R1
			BL		tnsieee
			STR		R8, [R11, #4]
			END
			
ieeetns		ADR		R5, SIGNMASK
			ADR		R6, IEEEEXPMASK
			ADR		R7, IEEESIGMASK
			LDR		R2, [R5]
			LDR		R3, [R6]
			LDR		R4, [R7]
			AND		R5, R9, R2
			AND		R6, R9, R3
			MOV		R6, r6, LSR #23
			ADD		R6, R6, #129
			AND		R7, R9, R4
			ADD		R7, R8, R7, LSL #8
			ORR		R8, R5, R6
			ORR		R8, R8, R7
			MOV		PC, LR
			
tnsieee		ADR		R5, SIGNMASK
			ADR		R6, TNSSIGMASK
			ADR		R7, TNSEXPMASK
			LDR		R2, [R5]
			LDR		R3, [R6]
			LDR		R4, [R7]
			AND		R5, R9, R2
			AND		R6, R9, R3
			MOV		R6, R6, LSR #8
			AND		R7, R9, R4
			SUB		R7, R7, #129
			ADD		R7, R8, R7, LSL #23
			ORR		R8, R5, R6
			ORR		R8, R8, R7
			MOV		PC, LR
			
			
			
SIGNMASK		DCD		0x80000000  ; Mask for sign bit
IEEEEXPMASK	DCD		0x7F800000  ; Mask for IEEE Exponent
IEEESIGMASK	DCD		0xFFFF007F  ; Mask for IEEE Significand
TNSSIGMASK	DCD		0x7FFFFE00  ; Mask for TNS Significand
TNSEXPMASK	DCD		0x000001FF  ; Mask for TNS Exponent
			
floats		DCD		0xa0bcff0d, 0x13c0adea
tns			FILL		16
ieee			FILL		16
