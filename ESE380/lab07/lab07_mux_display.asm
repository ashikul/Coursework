;**********************************************************************
;**********************************************************************
;* Author:	Ashikul Alam	1082212262
;* 			Mahamadou Bagayoko	108885352
;*			ESE 380
;*			Section 3 Bench 01
;*			Lab 07: Using Subroutines for Program Modularity
;*			Design Task 1
;*
;* lab07_mux_display.asm
;* 	
;* DESCRIPTION
;*	A program that intializes and then calls the mux_display subroutine
;*
;* outputs:
;*	PORT B = 7-Segment LED, bits 0-3
;*	PORT A = PA0 Transistor Driver, 0 to turn ON
;*				
;*
;* register Assignments/Purposes
;*		r0 - dig0
;* 		r1 - dig1
;* 		r2 - dig2
;*		r20 = mux_display counter
;*
;* Target: ATmega16 @ 1 MHz 
;***********************************************************************

.nolist
.include "m16def.inc"
.list


.cseg
intialization:
    ;Configure port B as an output port
    ldi r16, $FF        ;load r16 with all 1s
    out DDRB, r16       ;port B - all bits configured as outputs

    ;Configure port A bit 0 & bit 1 as an output
    ldi r16, $07        ;load r16 with a 1 in the bit 0,1,2 position
    out DDRA, r16       ;port A - bit 0 as an output

 	;Initialize stack pointer to allow subroutine calls
    ldi r20, LOW(RAMEND)    ;load low byte of stack pointer    
    out SPL, r20
    ldi r20, HIGH(RAMEND)   ;load high byte of stack pointer
    out SPH, r20

	;load LED register values for testing
	ldi r20, $F0
	mov r2, r20		;dig2
	ldi r20, $0F
	mov r1, r20		;dig1
	ldi r20, $00
	mov r0, r20		;dig0

	ldi r20, 0b00000110     ;mux_display_counter



main:

		call mux_display

		rjmp main

;***************************************************************************
;* 
;* "mux_display" - Multiplexes Seven-Segment Display
;*
;* Description: Each time subroutine is called it turns OFF the previous
;* digit and turns ON the next digit of a three digit seven segment display.
;* The segment values to be displayed are taken from registers r2 through r0
;* for digits dig2 to dig0 respectively. The subroutine maintains a digit
;* counter (r20) indicating which digit is currently being displayed.
;*
;* To keep each digit ON for a longer time requires a separate delay
;* subroutine. 
;*
;* Original author: Ken Short
;* Modified by: Ashikul Alam	1082212262
;* 				Mahamadou Bagayoko	108885352
;* Target: ATmega16
;* Number of words: 20
;* Number of cycles: 10-13
;* Low registers modified: none
;* High registers modified: r20 
;*
;* Parameters: The segment values to be displayed are passed in r0 - r2
;* r0 - dig0
;* r1 - dig1
;* r2 - dig2
;*
;* Notes: 0s turn on digits and 0s turn on segments
;* The segments are a through g at PB6 through PB0 respectively.
;* The digit drivers are PA2 through PA0 for digits dig2 through dig0.
;*
;***************************************************************************

.cseg
mux_display:

	sbrs r20, 0		;check if r20 is 110
	rjmp display0
	sbrs r20, 1		;check if r20 is 101
	rjmp display1
	rjmp display2	;check if r20 is 011

display0:
    out PORTB, r0      ;output image to seven-segment display DIG0
    out PORTA, r20      ;PA0 digit ON time, others OFF
	ldi r20, 0b00000101		;counter for next
	ret
display1:
    out PORTB, r1      ;output image to seven-segment display DIG1
    out PORTA, r20      ;PA1 digit ON time, others OFF
	ldi r20, 0b00000011		;counter for next
	ret
display2:
    out PORTB, r2      ;output image to seven-segment display DIG2
    out PORTA, r20      ;PA2 digit ON time, others OFF
	ldi r20, 0b00000110		;counter for next
	ret

