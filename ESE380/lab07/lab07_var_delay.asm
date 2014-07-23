;*******************************************************************
;********************************************************************
;* Author:	Ashikul Alam	1082212262
;* 			Mahamadou Bagayoko	108885352
;*			ESE 380
;*			Section 3 Bench 01
;*			Lab 07: Using Subroutines for Program Modularity
;*			Design Task 4
;*
;* lab07_var_delay.asm
;* 	
;* DESCRIPTION
;*	A program that intializes and then calls the var_delay subroutine
;*
;* outputs:
;*	PORT A = PA7 Toggle Delay
;*
;* register Assignments/Purposes
;*		r16 = counter
;*
;* Target: ATmega16 @ 1 MHz 
;********************************************************************

.nolist
.include "m16def.inc"
.list


.cseg
intialization:


	;Configure port A bit 7 as an output
    ldi r16, $80        
    out DDRA, r16   
	
	    

 	;Initialize stack pointer to allow subroutine calls
    ldi r16, LOW(RAMEND)    ;load low byte of stack pointer    
    out SPL, r16
    ldi r16, HIGH(RAMEND)   ;load high byte of stack pointer
    out SPH, r16
	


main:

		ldi r16,1
		cbi PORTA, 7
		call var_delay

		ldi r16,1
		sbi PORTA, 7
		call var_delay

		rjmp main

;*********************************************************************
;* 
;* "var_delay" - Hexadecimal to Seven-Segment Table Look Up
;*
;* Description: This subroutine is passed a value in r16 that is the 
;* desired duration of the delay in 0.1 ms increments. Thus, the 
;* delay can range from approximately 0.1 ms to 25.6 ms.
;*
;* Original description: Ken Short
;* Modified by: Ashikul Alam	1082212262
;* 				Mahamadou Bagayoko	108885352
;* Target: ATmega16 @ 1 MHz
;* Number of words: 10
;* Number of cycles: r16 * 100
;* Low registers modified: none
;* High registers modified: r16
;*
;* Parameters: The segment values to be displayed are passed to r16
;* r16 - delay counter
;*********************************************************************


.cseg
var_delay:		;delay is approximately r16 value * 0.1ms

	delayloop:	;one delay loop is 100 clock cycles or 0.1 ms
		push r16		;push r16 to save,
						;and reuse register 16, 2 clock cycles
		ldi r16, 31		;1 clock cycle
		innerloop:		;loop will run 32 times ~ 92 clock cycles or
						; 92us
			dec r16
			brne innerloop

		pop r16			;pop r16 ,2 clock cycles
    	dec r16			;doesn't work if r16 is intially 0, goes to 255
						;1 clock cycles
    	brne delayloop	;2 clock cycles
		ret				

	


