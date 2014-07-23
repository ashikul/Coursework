;*********************************************************
;*********************************************************
;* Author:	Ashikul Alam	1082212262
;* 			Mahamadou Bagayoko	108885352
;*			ESE 380
;*			Section 3 Bench 01
;*			LABORATORY 9: External and Internal Interrupts
;*			Design Task 2
;*
;* lab09_ADC_sign1.asm
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
	ldi r16, $FF    	;all segments OFF
    out PORTB, r16

    ;Configure port A bit 0 & bit 1 as an output
    ldi r16, $07       	;PA2 - PA0 outputs, others inputs
    out DDRA, r16  
	ldi r16, $07    	;all digits OFF
    out PORTA, r16     

	;Configure port D as an input port
    ldi r16, $00        ;load r16 with all 0s 
    out DDRD, r16       ;port D - all bits configured as inputs
    ldi r16, $0F        ;enable pull-up resistors by outputting
    out PORTD, r16      ;all 1s to PORTD

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
	

	
	;Initialize stack pointer to allow subroutine calls
    ldi r16, LOW(RAMEND)    ;load low byte of stack pointer    
    out SPL, r16
    ldi r16, HIGH(RAMEND)   ;load high byte of stack pointer
    out SPH, r16


	;configure interupt
	ldi r16, (1 << ISC11) | (1 << ISC10)    ;interrupt sense  
    out MCUCR, r16      ;rising edge at INT1 requests interrupt
	ldi r16, 1<<INT1    ;enable interrupt request at INT1    
    out GICR, r16
	
	ldi r16,(0<<CS02) | (1<<CS01) | (0<<CS00)
	out TCCR0,r16 ; Timer clock = system clock / 8
	ldi r16, $FF    ;all segments OFF
    out PORTB, r16
	ldi r16,1<<TOIE0
	out TIMSK,r16 ; Enable Timer/Counter0 Overflow Interrupt

	;Design Task 2/3/4 ADC

	ldi r16, $A4
	out ADCSRA, r16
							;0b1010 0100 or $A4
							;ADEN -bit 7- enabled	;
							;ADSC -bit 6- disabled
							;ADFR -bit 5- enabled	;
							;ADIF -bit 4- off
							;ADIE -bit 3- off	;
							;ADPS2:0 -bits 2:0 - prescale16
								

	
	ldi r16, $07		
	out ADMUX, r16
	
							;0b00000111 or $07
							;00 internal Vref is off
							;0 Left Adjust off
							;00101 ADC5	<-DesignTask4
							;00110 ADC6 <-DesignTask3
							;00111 ADC7 <-DesignTask2



	call display_post 	;POST test
	  	
	sei                 ;set global interrupt enable

;Two interrupts active
startADC:
	sbi ADCSRA, ADSC ;start conversion,freerunning

pollADC:
	
	sbis ADCSRA, ADIF ;end of conversion check
	rjmp pollADC

	sbi ADCSRA, ADIF ;write 1 to clear ADIF flag


	;so ADCH  & ADCL is a combined 10 bit value
	;that needs to displayed on 3 LEDS
	;the 10 bit value is seperated into 3 4bit values
	;these values are sent into the hex

displayADC:	
				;using registers r16 and r17
	in r16, ADCL   
	mov r17, r16  ;copy r16 into r17

	andi r16, $0F ;mask, want low nibble of ADCL
	call hex_2_7seg ;r16 converted into an LED display value
	mov r0, r16     ;r16 into dig0

	mov r16, r17  ;get ADCL from r17
	andi r16, $F0      ;mask, want high nibble of ADCL
	swap r16 	  ;swap or rightshift 4 times
	call hex_2_7seg ;r16 converted into an LED display value
	mov r1, r16     ;r16 into dig1

	in r16, ADCH   ;load in 2msb of adc
	andi r16, $0F    ;mask, want low nibble of ADCH
	call hex_2_7seg ;r16 converted into an LED display value
	mov r2, r16     ;r16 into dig2
	 
	rjmp pollADC

		
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

mux_display_isr:
    push r16            ;save registers and status
    in r16, SREG
    push r16

    in r16, PORTA       ;turn all digits OFF
    andi r16, 0b11111000
    ori r16, 0b00000111
    out PORTA, r16

    nop                 ;slight delay to prevent display ghosting
    nop
    nop
    nop
    nop

    inc r20        ;increment digit counter

    cpi r20, 0    ;check value of digit counter &  transfer control
    breq lite_dig0
    cpi r20, 1
    breq lite_dig1
    cpi r20, 2
    breq lite_dig2
    ldi r16, 0    ;digit counter was incremented to 3,change to 0
    mov r20, r16

lite_dig0:                  ;activate digit 0
    out PORTB, r0           ;output digit 0 seven-segment value
    cbi PORTA, 0            ;turn on digit 0 driver
    rjmp exit_update_display

lite_dig1:                  ;activate digit 1
    out PORTB, r1           ;output digit 1 seven-segment value
    cbi PORTA, 1            ;turn on digit 1 driver
    rjmp exit_update_display

lite_dig2:                  ;activate digit 2
    out PORTB, r2           ;output digit 2 seven-segment value
    cbi PORTA, 2            ;turn on digit 2 driver

exit_update_display:
    pop r16             ;restore status and registers
    out SREG, r16
    pop r16
    reti

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


left_shift_display:
    push r17        ;save SREG and registers
    in r17, SREG
    push r17

    rcall hex_2_7seg    ;convert hex value in r16 to seven-segment

    mov r2, r1      ;shift left r2,r1,r0 <- r16
    mov r1, r0
    mov r0, r16

    pop r17         ;restore SREG and registers
    out SREG, r17
    pop r17
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

hex_2_7seg:
    push r18                ;save registers and SREG
    mov r18, r16
    in r16, SREG
    push r16
    push r30
    push r31

    andi r18, $0F           ;mask for hex digit
    ldi ZH, high (hextable * 2) ;set Z to point to start of table
    ldi ZL, low (hextable * 2)
    ldi r16, $00        ;add offset to Z pointer
    add ZL, r18
    adc ZH, r16
    lpm r16, Z          ;load byte from table pointed to by Z

    pop r31         ;resore registers and SREG
    pop r30
    pop r18
    out SREG, r18
    pop r18

    ret

    ;Table of segment values to display digits 0 - F

hextable: .db $01, $4F, $12, $06, $4C, $24, $20, $0F, $00, $0C
            .db $08, $60, $30, $42, $30, $38


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


	var_delay:   ;delay for ATmega16 @ 1MHz
    push r17
    in r17, SREG
    push r17

o_loop:
    ldi r17, 32         ; 
i_loop:
    dec r17
    brne i_loop
    dec r16
    brne o_loop

    pop r17
    out SREG, r17
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

