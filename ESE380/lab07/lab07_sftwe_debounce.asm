;*************************************************************
;*************************************************************
;* Author:	Ashikul Alam	1082212262
;* 			Mahamadou Bagayoko	108885352
;*			ESE 380
;*			Section 3 Bench 01
;*			Lab 07: Using Subroutines for Program Modularity
;*			Design Task 5
;*
;* lab07_sftwe_debounce.asm
;* 	
;* DESCRIPTION
;*	A program that debounces push buttons with software and
;*	various subroutines
;*
;* inputs: 
;*	PORT D =  bits 0-2 is encoder input
;*			  bit 7 is push button output:
;* outputs:
;*	PORT D = bit 6 is flip-flop clear
;*	PORT B = 7-Segment LED, bits 0-3
;*	PORT A = PA0 Transistor Driver, 0 to turn ON				
;*
;* register Assignments/Purposes
;*		r0 - dig0
;* 		r1 - dig1
;* 		r2 - dig2
;* 		r16 - hex input value to look up in hex_2_7seg 
;*		r20 = mux_display counter
;*
;* Target: ATmega16 @ 1 MHz 
;**************************************************************

.nolist
.include "m16def.inc"
.list

;Equates for PortD
.equ CLRFF = 6  ;flip-flop clear input
.equ QFF = 7    ;flip-flop Q output

.cseg
intialization:
    ;Configure port B as an output port
    ldi r16, $FF        ;load r16 with all 1s
    out DDRB, r16       ;port B - all bits configured as outputs

    ;Configure port A bit 0 & bit 1 as an output
    ldi r16, $07     ;load r16 with a 1 in the bit 0,1,2position
    out DDRA, r16       ;port A - bit 0 as an output

	;Configure port D as an input port
    ldi r16, $40        ;load r16 with all 0s except PD6
    out DDRD, r16       ;port D - all bits configured as inputs
    ldi r16, $FF        ;enable pull-up resistors by outputting
    out PORTD, r16      ;all 1s to PORTD

	;clear FF
	cbi PORTD, CLRFF
	sbi PORTD, CLRFF


 	;Initialize stack pointer to allow subroutine calls
    ldi r20, LOW(RAMEND)    ;load low byte of stack pointer    
    out SPL, r20
    ldi r20, HIGH(RAMEND)   ;load high byte of stack pointer
    out SPH, r20

	;Initialize stack pointer to allow subroutine calls
    ldi r16, LOW(RAMEND)    ;load low byte of stack pointer    
    out SPL, r16
    ldi r16, HIGH(RAMEND)   ;load high byte of stack pointer
    out SPH, r16

	;load LED register values with 0s
	ldi r20, $00
	mov r2, r20		;dig2
	mov r1, r20		;dig1
	mov r0, r20		;dig0   
	
	ldi r20, 0b00000110  ;mux_display_counter


main:
		 
		call mux_display	;display dig0
		call mux_display	;display dig1
		call mux_display	;display dig2
		
		sbis PIND, QFF		;check for flip-flop logic 1 PD7
		rjmp main
		
		;clear FF
		cbi PORTD, CLRFF
		sbi PORTD, CLRFF

		in r16, PIND
		call left_shift_display
		
		ldi r16,100    ;wait 10ms for debounce to go away
		call var_delay

		rjmp main

;*************************************************************
;* "mux_display" - Multiplexes Seven-Segment Display
;*
;* Description: Each time subroutine is called it turns OFF the 
;* previous digit and turns ON the next digit of a three digit 
;* seven segment display.The segment values to be displayed are 
;* taken from registers r2 through r0 for digits dig2 to dig0
;* respectively. The subroutine maintains  a digit counter (r20) 
;* indicating which digit is currently being displayed.
;* To keep each digit ON for a longer time requires a separate 
;* delay subroutine. 
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
;* Parameters: The segment values to be displayed are passed in
;*  r0 - r2
;* r0 - dig0
;* r1 - dig1
;* r2 - dig2
;*
;* Notes: 0s turn on digits and 0s turn on segments
;* The segments are a through g at PB6 through PB0 respectively.
;* The digit drivers are PA2 through PA0 for digits dig2 through.
;*	 dig0
;**************************************************************

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


;*****************************************************************
;* 
;* "left_shift_display" - Subroutine to Left Shift the Seven-Segment
;*							 Display and Enter a New Digit
;*
;*	calls "hex_2_7seg" subroutine
;*
;* Description: This subroutine is passed a value in r16. 
;* This value is interpreted as a right justified hexadecimal digit. 
;* The subroutine  shifts the registers r2 through r0 one digit 
;* position  to the left. The subroutine then enters the seven-segment 
;* value, corresponding to the hexadecimal digit passed in r16, into r0. 
;* To do the later, subroutine left_shift_display calls subroutine 
;* hex_2_7seg to get the seven-segment value.
;* Original description by: Ken Short
;* Modified by: Ashikul Alam	1082212262
;* 				Mahamadou Bagayoko	108885352
;* Target: ATmega16
;* Number of words: 5
;* Number of cycles: 9 + 13 from hex_2_7seg subroutine = 22
;* Low registers modified: none
;* High registers modified: r16
;*
;* Parameters: The segment values to be shifted are passed in r0 - r2
;* r0 - dig0
;* r1 - dig1
;* r2 - dig2
;* r16 - hex input value to be used in hex_2_7seg to load in r0
;*
;*********************************************************************

.cseg
left_shift_display:

	mov r2, r1
	mov r1, r0
	call hex_2_7seg
	mov r0, r16
	ret

;***************************************************************************
;* 
;* "hex_2_7seg" - Hexadecimal to Seven-Segment Table Look Up
;*
;* Description: This subroutine receives a hexadecimal value, right 
;* justified, in r16 and returns its seven-segment representation in r16.
;* If the value received  is greater than 15, the value displayed should be 
;* the input value modulo 16. The segments are assigned with a through g in
;* bits 6 through 0. 0s in the seven-segment pattern turn segments ON and 
;*1s turn segments OFF.
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
;********************************************************************

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


;************************************************************************
;* 
;* "var_delay" - Hexadecimal to Seven-Segment Table Look Up
;*
;* Description: This subroutine is passed a value in r16 that is the 
;* desired duration of the delay in 0.1 ms increments. Thus, the delay  
;* can range from approximately 0.1 ms to 25.6 ms.
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
;************************************************************************

.cseg
var_delay:		;delay is approximately r16 value * 0.1ms

	delayloop:	;one delay loop is 100 clock cycles or 0.1 ms
		push r16		;push r16 to save, and reuse register 16, 2 clock cycles
		ldi r16, 31		;1 clock cycle
		innerloop:		;loop will run 32 times ~ 92 clock cycles or 92us
			dec r16
			brne innerloop

		pop r16			;pop r16 ,2 clock cycles
    	dec r16			;doesn't work if r16 is intially 0, goes to 255
						;1 clock cycles
    	brne delayloop	;2 clock cycles
		ret	
			

	


