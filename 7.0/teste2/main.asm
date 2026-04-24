;
; teste2.asm
;
; Created: 17/04/2026 09:56:59
; Author : Carlos Edu
;


; Replace with your application code

.nolist
.include "m328Pdef.inc"
.list

.equ LED = PB5 //LED e o substituto de PB5 na programacao

.ORG 0x000 //endereço de início de escrita do código
INICIO:
	LDI R16,0xFF //carrega R16 com o valor 0xFF
	OUT DDRB, R16 //configura todos os pinos do PORTB como saída
PRINCIPAL:
	SBI PORTB, LED //coloca o pino PB5 em 5V
	RCALL ATRASO //chama a sub-rotina de atraso
	CBI PORTB, LED //coloca o pino PB5 em OV
	RCALL ATRASO //chama a sub-rotina de atraso
	RJMP PRINCIPAL //volta para PRINCIPAL
ATRASO: //atraso de aprox. 200 ms

volta:
	DEC R17 //decrementa R17, comeca com 0x00
	BRNE volta //enquanto R17 > 0 fica decrementando R17
	DEC R18 //decrementa R18, comeca com 0x00
	BRNE volta //enquanto R18 > 0 volta a decrementar R18
	DEC R19 //decrementa R19
	BRNE volta //enquanto R19 > 0 vai para volta
	RET
