;**********************************************************************
;**********************************************************************
;* Author:	Ashikul Alam	1082212262
;* 			Mahamadou Bagayoko	108885352
;*			ESE 380
;*			Section 3 Bench 01
;*			Lab 07: Using Subroutines for Program Modularity
;*			Design Task 2
;*
;* lab07_hex_2_7seg.asm
;* 	
;* DESCRIPTION
;*	A program that intializes and then calls the hex_2_7seg subroutine
;*
;* register Assignments/Purposes
;*		r16 = mux_display counter
;*
;* Target: ATmega16 @ 1 MHz 
;***********************************************************************

.nolist
.include "m16def.inc"
.list


.cseg
intialization:

 	;Initialize stack pointer to allow subroutine calls
    ldi r16, LOW(RAMEND)    ;load low byte of stack pointer    
    out SPL, r16
    ldi r16, HIGH(RAMEND)   ;load high byte of stack pointer
    out SPH, r16


main:

		ldi r16,$00  ;look up this value 
		call hex_2_7seg

		rjmp main

;***************************************************************************
;* 
;* "hex_2_7seg" - Hexadecimal to Seven-Segment Table Look Up
;*
;* Description: This subroutine receives a hexadecimal value, right justified,
;* in r16 and returns its seven-segment representation in r16. If the value received 
;* is greater than 15, the value displayed should be the input value modulo 16.
;* The segments are assigned with a through g in bits 6 through 0. 0s in the 
;* seven-segment pattern turn segments ON and 1s turn segments OFF.
;*
;* Original author: Ken Short
;* Modified by: Ashikul Alam	1082212262
;* 				Mahamadou Bagayoko	108885352
;* Target: ATmega16
;* Number of words: 7
;* Number of cycles: 13
;* Low registers modified: none
;* High registers modified: r16
;*
;* Parameters: The segment values to be displayed are passed to r16
;* r16 - input hex value to a 7seg output 
;***************************************************************************

.cseg
hex_2_7seg:

   	andi r16, $0F		;r16 modulo 16 by masking with $0F
    ldi ZH, high (hextable * 2)    ;set Z to point to start of table
    ldi ZL, low (hextable * 2)              
   	add ZL, r16					 ;add offset to Z pointer
    lpm r16, Z                  ;load byte from table pointed to by Z
	ret



;Table of segment values to display digits 0 - F
hextable: .db $01, $4F, $12, $06, $4C, $24, $20, $0F, $00,$0C,$08,$60,$31,$42,$30,$38
			;  0    1    2 	 3    4     5    6    7    8   9,  A,  B,  C,  D,  E,   F....
