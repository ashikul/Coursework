;*********************************************************
;*********************************************************
;* Author:	Ashikul Alam	1082212262
;* 			Mahamadou Bagayoko	108885352
;*			ESE 380
;*			Section 3 Bench 01
;*			LABORATORY 9: External and Internal Interrupts
;*			Design Task 1
;*
;* lab09_display_post.asm
;* 	
;* DESCRIPTION
;*	A program that constantly loops and has 2 interrupts.
;* "keypress_isr" is an external interrupt
;* "mux_display" is a timer interrupt
;* Also has an intial POST routine.
;*	
;* inputs: 
;*	PORT D =  bits 0-2 is encoder input
;*			  bit 3 flip-flop input
;*  		  
;* outputs:
;*	PORT D = bit 6 is flip-flop clear
;*	PORT B = 7-Segment LED, bits 0-7
;*	PORT A = bits 0-3 PA0/1/2 Transistor Driver, 
;*								0 to turn ON				
;*
;* register Assignments/Purposes
;*		r0 - dig0
;* 		r1 - dig1
;* 		r2 - dig2
;* 		r16 - hex input value to look up in hex_2_7seg 
;*		r20 = mux_display counter
;*
;* Target: ATmega16 @ 1 MHz 
;**********************************************************

.nolist
.include "m16def.inc"
.list

.cseg

reset:

.org RESET              ;reset interrupt vector
    rjmp intialization          ;program starts here at reset
.org INT1addr           ;INT1 interrupt vector
    rjmp keypress_isr
.org 0x12 				;Timer interrupt vector
 rjmp mux_display_isr


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
    ldi r16, $BF        ;enable pull-up resistors by outputting
    out PORTD, r16      ;all 1s to PORTD

	;clear FF
	cbi PORTD, 6
	sbi PORTD, 6

 	;Initialize stack pointer to allow subroutine calls
    ldi r20, LOW(RAMEND)    ;load low byte of stack pointer    
    out SPL, r20
    ldi r20, HIGH(RAMEND)   ;load high byte of stack pointer
    out SPH, r20

	;load LED register values with 0s
	ldi r20, $00
	mov r2, r20		;dig2
	mov r1, r20		;dig1
	mov r0, r20		;dig0   
	
	ldi r20, 0b00000110  ;mux_display_counter
	
	;Initialize stack pointer to allow subroutine calls
    ldi r16, LOW(RAMEND)    ;load low byte of stack pointer    
    out SPL, r16
    ldi r16, HIGH(RAMEND)   ;load high byte of stack pointer
    out SPH, r16

	ldi r16, (1 << ISC11) | (1 << ISC10)    ;interrupt sense ;mod
						;control bits
    out MCUCR, r16      ;rising edge at INT1 requests interrupt
    ldi r16, 1<<INT1    ;enable interrupt request at INT1    
    out GICR, r16
	
	ldi r16,(0<<CS02) | (1<<CS01) | (0<<CS00)
	out TCCR0,r16 ; Timer clock = system clock / 8

	ldi r16,1<<TOIE0
	out TIMSK,r16 ; Enable Timer/Counter0 Overflow Interrupt

	call display_post ;POST test
	  	
	sei                 ;set global interrupt enable

;Two interrupts active
main:
	rjmp main	

		
;***************************************************
;* "mux_display_isr" - Multiplexes Seven-Segment Display
;*							Interrupt
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
;* Number of cycles: 20-23
;* Low registers modified: none
;* High registers modified: r20, r16
;*
;* Parameters: The segment values to be displayed are passed in
;* r0 - r2
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
mux_display_isr:

	push r16
	in r16,SREG
	push r16
 

	sbrs r20, 0		;check if r20 is 110
	rjmp display0
	sbrs r20, 1		;check if r20 is 101
	rjmp display1
	rjmp display2	;check if r20 is 011

display0:
    out PORTB, r0      ;output image to seven-segment display DIG0
    out PORTA, r20      ;PA0 digit ON time, others OFF
	ldi r20, 0b00000101		;counter for next
	rjmp end
display1:
    out PORTB, r1      ;output image to seven-segment display DIG1
    out PORTA, r20      ;PA1 digit ON time, others OFF
	ldi r20, 0b00000011		;counter for next
	rjmp end
display2:
    out PORTB, r2      ;output image to seven-segment display DIG2
    out PORTA, r20      ;PA2 digit ON time, others OFF
	ldi r20, 0b00000110		;counter for next
	rjmp end

end:
 	
    pop r16             ;restore SREG
    out SREG,r16
    pop r16             ;restore r16

    reti                ;return from interrupt

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

;*************************************************************
;* 
;* "hex_2_7seg" - Hexadecimal to Seven-Segment Table Look Up
;*
;* Description: This subroutine receives a hexadecimal value, right 
;* justified, in r16 and returns its seven-segment representation 
;* in r16.If the value received  is greater than 15, the value  
;* displayed should be the input value modulo 16. The segments 
;* are assigned with a through g in bits 6 through 0. 0s in the 
;* seven-segment pattern turn segments ON an
;* 1s turn segments OFF.
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
;*************************************************************

.cseg
hex_2_7seg:

   	andi r16, $07		;r16 modulo 16 by masking with $0F ;modded
    ldi ZH, high (hextable * 2)    ;set Z to point to start of table
    ldi ZL, low (hextable * 2)              
   	add ZL, r16					 ;add offset to Z pointer
    lpm r16, Z                  ;load byte from table pointed to by Z
	ret



;Table of segment values to display digits 0 - F
hextable: .db $01, $4F, $12, $06, $4C, $24, $20, $0F, $00,$0C,$08,$60,$31,$42,$30,$38
			;  0    1    2 	 3    4 5 6 7 8 9,A, B,C,D,E,F....


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
;********************************************************************


	var_delay:		;delay is approximately r16 value * 0.1ms
		push r17	;push r16 to save
	
	
	delayloop:	;one delay loop is 100 clock cycles or 0.1 ms

		ldi r17, 32
	innerloop:		;loop will run 32 times ~ 92 clock cycles or
						; 92us
		dec r17
		brne innerloop
		dec r16			;doesn't work if r16 is intially 0, goes to 255
						;1 clock cycles
    	brne delayloop	;2 clock cycles
		pop r17
		ret				

;****************************************************************
;* 
;* "keypress_isr" - Count Interrupts at INT1
;*
;* 		calls "left_shift_display"
;*
;* Description: Edge triggered interrupt at INT1 (PD3) 
;* to left shift the displays
;*
;* Modified by: Ashikul Alam	1082212262
;* 				Mahamadou Bagayoko	108885352
;* Target: ATmega16
;* Number of words: 0
;* Number of cycles: 41
;* Low registers modified: none
;* High registers modified: r16
;*
;* Parameters:  Uses register r16 to taken PIND value and 
;* call subroutine "left_shift_display"
;* .
;*
;* Notes: 
;*
;******************************************************************

    ;INT1 interrupt service routine


keypress_isr:
    push r16            ;save r16
    in r16, SREG        ;save SREG
    push r16
	push r20
	
	
	ldi r16, 10     ;wait var x 0.1ms for debounce to go away
	call var_delay

	 
	in r16, PIND
	call left_shift_display
	
	ldi r16, 0<<INT1    ;disable interrupt request at INT1    
    out GICR, r16
	sei					;enable mux_display interrupt

	rjmp background

keypressfinish:

 	ldi r16,10    ;wait var x 0.1ms for debounce to go away
	call var_delay

	ldi r16, 1<<INT1    ;enable interrupt request at INT1    
    out GICR, r16
	
	pop r20	
    pop r16             ;restore SREG
    out SREG,r16
    pop r16             ;restore r16

    reti                ;return from interrupt

background:				;checks for release
	
	sbis PIND, 3		;check E0 for 0 for break

	rjmp keypressfinish	;go back to interrupt
	rjmp background		;loop checking E0 hold press
		

;****************************************************************
;* 
;* "display_post" - Power-on self test (POST) subroutine
;*
;* Description: This subroutine lights all of the segments of
;* all of the 
;* digits of the seven-segment display for approximately one 
;* second and then
;* blanks the display.
;* 
;* 50 ms x 20 = 1 second
;*
;* Original description by: Ken Short
;* Modified by: Ashikul Alam	1082212262
;* 				Mahamadou Bagayoko	108885352
;* Target: ATmega16 @ 1 MHz
;* Number of words: 
;* Number of cycles: 
;* Low registers modified: none
;* High registers modified: r16, r17,r18
;*
;* Parameters: 
;* 
;*****************************************************************

display_post:

ldi r16, $00
out PORTB, r16 ;turn all segements

ldi r18, 20 ; 20 times 50ms is calledfor 1 s

ldi r16, $FE   
out PORTA, r16 ;start with dig0 turned on

main_loop:
				;mux
sbis PINA, 0  ;if it displayed dig0
ldi r16, $FD  ;display dig1 next
sbis PINA, 1	;if it displayed dig1
ldi r16, $FB	;display dig2 next
sbis PINA, 2	;if it displayed dig2
ldi r16, $FE	;displat dig0 next

out PORTA, r16 ;turn on dig0/1/2

loop:

	call delay_50ms
	dec r18
	brne main_loop ;loop again to main loop if not 0
	ret			; one second delay is done

delay_50ms: ;50 ms delay for ATmega16 @ 1MHz
	ldi r17, 65
	outer_loop:
		ldi r16, $FF
		inner_loop:
			dec r16
			brne inner_loop ;branch if r16 not equal 0
		dec r17
		brne outer_loop ;branch if r17 not equal 0
	 	ret




