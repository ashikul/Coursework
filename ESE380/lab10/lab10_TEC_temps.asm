3;*********************************************************
;*********************************************************
;* Author:	Ashikul Alam	1082212262
;* 			Mahamadou Bagayoko	108885352
;*			ESE 380
;*			Section 3 Bench 01
;*			LABORATORY 10: Unsigned Binary Computations and 
;*			Binary to BCD Conversion - 
;*			Introduction to the Thermoelectric Cooler
;*			Design Task 1
;*
;* lab10_TEC_temps.asm
;* 	
;* DESCRIPTION
;*	A program that has two interrupt subroutines and a
;*  a main task of computing an ADC input binary
;*  to a decimal 3 digits display on the LEDs.
;*
;* Uses subroutines from ATMEL
;* "mpy16u","div16u","bin2BCD16"
;*	
;* inputs: 
;*	PORT A =  ADC 5-7
;*  PORT D = Push Buttons 7-5
;*			  
;*  		  
;* outputs:
;*	PORT D = PD7 LED
;*  PORT C = PC1 & 0 LEDs
;*	PORT B = 7-Segment LED, bits 0-7
;*	PORT A = bits 0-3 PA0/1/2 Transistor Driver, 
;*							 
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

.org 0             ;reset interrupt vector
    jmp intialization          ;program starts here at reset

.org INT1addr           ;INT1 interrupt vector
    jmp keypress_isr

.org OVF0addr 				;Timer interrupt vector
 	jmp mux_display_isr


intialization:
    ;Configure port B as an output port
    ldi r16, $FF        ;load r16 with all 1s
    out DDRB, r16       ;port B - all bits configured as outputs
	
    ;Configure port A bit 0 & bit 1 as an output
    ldi r16, $E7       	;PA2 - PA0 outputs, others inputs
    out DDRA, r16  
	ldi r16, $07    	;all digits OFF
    out PORTA, r16     

	;Configure port D as an input port
    ldi r16, $80        ;PD7 LED Output
    out DDRD, r16       
   

	;Configure port C
	ldi r16, $C0        ;PC0/PC1 LED Output
    out DDRC, r16  


	;load LED register values with 0s
	ldi r24, $00
	mov r2, r24		;dig2
	mov r1, r24		;dig1
	mov r0, r24		;dig0   
	
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


	ldi r16, $24  
	out ADCSRA, r16
							;0b1010 0100 or $A4
							;ADEN -bit 7- disabled	
							;ADSC -bit 6- disabled
							;ADFR -bit 5- enabled ???	;
							;ADIF -bit 4- off
							;ADIE -bit 3- off	;
							;ADPS2:0 -bits 2:0 - prescale16
								

	
	ldi r16, $C7		
	out ADMUX, r16
	
							;0b00000111 or $07
							;11 internal Vref is on
							;0 Left Adjust off
							;00101 ADC5	<-DesignTask4
							;00110 ADC6 <-DesignTask3
							;00111 ADC7 <-DesignTask2



	call display_post 	;POST test
	  	
	sei                 ;set global interrupt enable

;Two interrupts active
startADC:
	sbi ADCSRA, ADSC ;start conversion,freerunning


main:
pollADC:
	
	sbis ADCSRA, ADIF ;end of conversion check
	rjmp pollADC

	sbi ADCSRA, ADIF ;write 1 to clear ADIF flag


displayADC:	

;multiply ADC by 5

	in r16, ADCL   ;multiplicand low byte
	in r17, ADCH   ;multiplicand high byte

	ldi r18, 5     ;multiplier low byte
	ldi r19, 0 		;multiplity high byte

	rcall mpy16u
	;desired result is now in r18, r19

;divide ADC by 2
	
	mov r16, r18   ;dividend low byte
	mov r17, r19   ;dividend high byte

	ldi r18, 2     ;divisor low byte
	ldi r19, 0 	   ;divisor high byte

	rcall div16u
	;desired result is now in r16,r17

;convert to BCD
	
	;r16 has Binary value Low Byte
	;r17 has Binary value High Byte

	rcall bin2BCD16

	;desired result in r13,r14

	;r13 low nibble is BCD Digit 0
	;put into DIG0
	
	mov r16, r13
	andi r16, $0F ;mask, want low nibble 
	call hex_2_7seg ;r16 converted into an LED display value
	cbr r16, 7 ;turn decimal ON
	mov r0, r16     ;r16 into dig0

	
	;r13 high nibble is BCD Digit 1
	;put into DIG1

	mov r16, r13
	swap r13		;want high nibble
	andi r16, $0F ;mask, 
	call hex_2_7seg ;r16 converted into an LED display value
	mov r1, r16     ;r16 into dig0

	;r14 low nibble is BCD Digit 2
	;put into DIG2
	
	mov r16, r14		
	andi r16, $0F ;mask, want low nibble
	call hex_2_7seg ;r16 converted into an LED display value
	mov r2, r16     ;r16 into dig0
	 
	rjmp startADC  ;start ADC again

		
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

    inc r24        ;increment digit counter

    cpi r24, 0    ;check value of digit counter &  transfer control
    breq lite_dig0
    cpi r24, 1
    breq lite_dig1
    cpi r24, 2
    breq lite_dig2
    ldi r16, 0    ;digit counter was incremented to 3,change to 0
    mov r24, r16

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
   
    rcall hex_2_7seg    ;convert hex value in r16 to seven-segment

    mov r2, r1      ;shift left r2,r1,r0 <- r16
    mov r1, r0
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
. 
hex_2_7seg:
   
    andi r16, $0F           ;mask for hex digit
    ldi ZH, high (hextable * 2) ;set Z to point to start of table
    ldi ZL, low (hextable * 2)
            
    add ZL, r16
    
    lpm r16, Z          ;load byte from table pointed to by Z
 	ori r16, $80 		;decimal off

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
	
 	 
    push r16           ;save r16
    in r16, SREG        ;save SREG
	push r16
	push r19
     
	

;LEDS OFF
	cbi PORTD, 7
	cbi PORTC, 0
	cbi PORTC, 1


	ldi r19, 10     ;wait var x 0.1ms for debounce to go away
	call var_delay

	 
	in r19, PIND
	andi r19, $07 ; mask, just want first 3 bit

	;check pushbutton press 7/6/5
	cpi r19, 7
	breq yellow
	cpi r19, 6
	breq green
	cpi r19, 5
	breq red

	rjmp finish_press
 

  

	;pushbutton 7				
yellow:
 
	ldi r19, $C6
	out ADMUX, r19
	sbi PORTD, 7

	rjmp finish_press

	;pushbutton 6
green:
 
	ldi r19, $C7
	out ADMUX, r19
	sbi PORTC, 0

	rjmp finish_press

	;pushbutton 5

red:
	 
	ldi r19, $C5
	out ADMUX, r19
	sbi PORTC, 1

finish_press:
	
	
 	;disable INT1

    ldi r19, (0 << INT1)
    out GICR, r19
	sei					;enable mux_display interrupt

pollkey:				;checks for release

	
	sbic PIND, 3		;check E0 for 0 for break
	rjmp pollkey		;loop checking E0 hold press


	ldi r19,10    ;wait var x 0.1ms for debounce to go away
	call var_delay
     

;enable INT1

    ldi r19, (1 << INT1)
    out GICR, r19
	
	pop r19 
    pop r16             ;restore SREG
    out SREG,r16             ;restore r16
	pop r16
 	 

    reti

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
;************************************************************** 

 
display_post:

ldi r16, $00
out PORTB, r16 ;turn all segements

;LEDS ON
	sbi PORTD, 7
	sbi PORTC, 0
	sbi PORTC, 1

ldi r18, 200 ; 20 times 50ms is calledfor 1 s

ldi r16, $FE   
out PORTA, r16 ;start with dig0 turned on

m_loop:
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
	brne m_loop ;loop again to main loop if not 0
	
	;LEDS OFF	
	cbi PORTD, 7
	cbi PORTC, 0
	cbi PORTC, 1

	ldi r16, $07
	out PORTA, r16 ;start with dig0 turned on
	
	ret			; one second delay is done

delay_50ms: ;50 ms delay for ATmega16 @ 1MHz
	ldi r17, 7
	outer_loop:
		ldi r16, $FF
		inner_loop:
			dec r16
			brne inner_loop ;branch if r16 not equal 0
		dec r17
		brne outer_loop ;branch if r17 not equal 0
	 	ret



;******************************************************************** 
;*
;* "mpy16u" - 16x16 Bit Unsigned Multiplication
;*
;* This subroutine multiplies the two 16-bit register variables 
;* mp16uH:mp16uL and mc16uH:mc16uL.
;* The result is placed in m16u3:m16u2:m16u1:m16u0.
;*  
;* Number of words	:14 + return
;* Number of cycles	:153 + return
;* Low registers used	:None
;* High registers used  :7 (mp16uL,mp16uH,mc16uL/m16u0,mc16uH/m16u1,m16u2
;*                          m16u3,mcnt16u)	
;*
;********************************************************************** 

;***** Subroutine Register Variables

.def	mc16uL	=r16		;multiplicand low byte
.def	mc16uH	=r17		;multiplicand high byte
.def	mp16uL	=r18		;multiplier low byte
.def	mp16uH	=r19		;multiplier high byte
.def	m16u0	=r18		;result byte 0 (LSB)
.def	m16u1	=r19		;result byte 1
.def	m16u2	=r20		;result byte 2
.def	m16u3	=r21		;result byte 3 (MSB)
.def	mcnt16u	=r22		;loop counter

;***** Code

mpy16u:	clr	m16u3		;clear 2 highest bytes of result
	clr	m16u2
	ldi	mcnt16u,16	;init loop counter
	lsr	mp16uH
	ror	mp16uL

m16u_1:	brcc	noad8		;if bit 0 of multiplier set
	add	m16u2,mc16uL	;add multiplicand Low to byte 2 of res
	adc	m16u3,mc16uH	;add multiplicand high to byte 3 of res
noad8:	ror	m16u3		;shift right result byte 3
	ror	m16u2		;rotate right result byte 2
	ror	m16u1		;rotate result byte 1 and multiplier High
	ror	m16u0		;rotate result byte 0 and multiplier Low
	dec	mcnt16u		;decrement loop counter
	brne	m16u_1		;if not done, loop more
	ret

;********************************************************************* 
;*
;* "div16u" - 16/16 Bit Unsigned Division
;*
;* This subroutine divides the two 16-bit numbers 
;* "dd8uH:dd8uL" (dividend) and "dv16uH:dv16uL" (divisor). 
;* The result is placed in "dres16uH:dres16uL" and the remainder in
;* "drem16uH:drem16uL".
;*  
;* Number of words	:19
;* Number of cycles	:235/251 (Min/Max)
;* Low registers used	:2 (drem16uL,drem16uH)
;* High registers used  :5 (dres16uL/dd16uL,dres16uH/dd16uH,dv16uL,dv16uH
;*			    dcnt16u)
;*
;********************************************************************** 

;***** Subroutine Register Variables

.def	drem16uL=r14
.def	drem16uH=r15
.def	dres16uL=r16
.def	dres16uH=r17
.def	dd16uL	=r16
.def	dd16uH	=r17
.def	dv16uL	=r18
.def	dv16uH	=r19
.def	dcnt16u	=r20

;***** Code

div16u:	clr	drem16uL	;clear remainder Low byte
	sub	drem16uH,drem16uH;clear remainder High byte and carry
	ldi	dcnt16u,17	;init loop counter
d16u_1:	rol	dd16uL		;shift left dividend
	rol	dd16uH
	dec	dcnt16u		;decrement counter
	brne	d16u_2		;if done
	ret			;    return
d16u_2:	rol	drem16uL	;shift dividend into remainder
	rol	drem16uH
	sub	drem16uL,dv16uL	;remainder = remainder - divisor
	sbc	drem16uH,dv16uH	;
	brcc	d16u_3		;if result negative
	add	drem16uL,dv16uL	;    restore remainder
	adc	drem16uH,dv16uH
	clc			;    clear carry to be shifted into result
	rjmp	d16u_1		;else
d16u_3:	sec			;    set carry to be shifted into result
	rjmp	d16u_1
	

;********************************************************************* 
;*
;* "bin2BCD16" - 16-bit Binary to BCD conversion
;*
;* This subroutine converts a 16-bit number (fbinH:fbinL) to a 5-digit
;* packed BCD number represented by 3 bytes (tBCD2:tBCD1:tBCD0).
;* MSD of the 5-digit number is placed in the lowermost nibble of tBCD2.
;*
;* Number of words	:25
;* Number of cycles	:751/768 (Min/Max)
;* Low registers used	:3 (tBCD0,tBCD1,tBCD2)
;* High registers used  :4(fbinL,fbinH,cnt16a,tmp16a)	
;* Pointers used	:Z
;*
;********************************************************************** 

;***** Subroutine Register Variables
. 
.equ	AtBCD0	=13		;address of tBCD0
.equ	AtBCD2	=15		;address of tBCD1

.def	tBCD0	=r13		;BCD value digits 1 and 0
.def	tBCD1	=r14		;BCD value digits 3 and 2
.def	tBCD2	=r15		;BCD value digit 4
.def	fbinL	=r16		;binary value Low byte
.def	fbinH	=r17		;binary value High byte
.def	cnt16a	=r18		;loop counter
.def	tmp16a	=r19		;temporary value

;***** Code
 
bin2BCD16:
	ldi	cnt16a,16	;Init loop counter	
	clr	tBCD2		;clear result (3 bytes)
	clr	tBCD1		
	clr	tBCD0		
	clr	ZH		;clear ZH (not needed for AT90Sxx0x)
bBCDx_1:lsl	fbinL		;shift input value
	rol	fbinH		;through all bytes
	rol	tBCD0		;
	rol	tBCD1
	rol	tBCD2
	dec	cnt16a		;decrement loop counter
	brne	bBCDx_2		;if counter not zero
	ret			;   return

bBCDx_2:ldi	r30,AtBCD2+1	;Z points to result MSB + 1
bBCDx_3:
	ld	tmp16a,-Z	;get (Z) with pre-decrement
;----------------------------------------------------------------
;For AT90Sxx0x, substitute the above line with:
;
;	dec	ZL
;	ld	tmp16a,Z
;
;----------------------------------------------------------------
	subi	tmp16a,-$03	;add 0x03
	sbrc	tmp16a,3	;if bit 3 not clear
	st	Z,tmp16a	;	store back
	ld	tmp16a,Z	;get (Z)
	subi	tmp16a,-$30	;add 0x30
	sbrc	tmp16a,7	;if bit 7 not clear
	st	Z,tmp16a	;	store back
	cpi	ZL,AtBCD0	;done all three?
	brne	bBCDx_3		;loop again if not
	rjmp	bBCDx_1		



