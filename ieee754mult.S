			;		ARM Programming Assignment #3: 32 bit IEEE 754 single-precision multiplier
			;
			;		Write a 32-bit floating point multiplier. The numbers will be represented
			;		in the single-precision IEEE 754 floating-point standard. The result should
			;		also be in IEEE 754 binary32. Assume you only have normalized numbers, i.e.
			;		the exponent is never 0b00000000.
			;		Write the result in the provided "fill" word.
			
			;		Your code here
			
			ADR		R2, floats
			LDR		R0, [R2]
			LDR		R1, [R2, #4]
			
			ADR		R5, SIGNMASK
			ADR		R6, IEEEEXPMASK
			ADR		R7, IEEESIGMASK
			LDR		R2, [R5]
			LDR		R3, [R6]
			LDR		R4, [R7]
			
			AND		R5, R0, R2
			MOV		R5, r5, LSR #31
			AND		R6, R0, R3
			MOV		R6, r6, LSR #23
			SUB		R6, R6, #128
			AND		R7, R0, R4
			
			AND		R8, R1, R2
			MOV		R8, r8, LSR #31
			AND		R9, R1, R3
			MOV		R9, r9, LSR #23
			SUB		R9, R9, #128
			AND		R10, R0, R4
			
			
			END
			
			
SIGNMASK		DCD		0x80000000  ; Mask for sign bit
IEEEEXPMASK	DCD		0x7F800000  ; Mask for IEEE Exponent
IEEESIGMASK	DCD		0x007FFFFF  ; Mask for IEEE Significand
			
floats		DCD		0xa0bcff0d, 0x13c0adea
result		FILL		8
