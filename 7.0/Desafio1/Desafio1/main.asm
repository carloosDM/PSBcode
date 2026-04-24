.nolist
.include "m328pdef.inc"
.list

.equ LED = PD2
.equ BOTAO = PD7 
.def AUX = R16 

.ORG 0x000

Inicializacoes:
	LDI AUX,0b00000100
	OUT DDRD,AUX
	LDI AUX, 0b11111111
	OUT PORTD, AUX
	NOP

Principal:
	SBIC PIND,BOTAO 
	RJMP Principal
	Esp_Soltar: 
	SBIS PIND, BOTAO 
	RJMP Esp_Soltar
	RCALL Atraso 
	SBIC PORTD, LED 
	RJMP Liga
	SBI PORTD, LED 
	RJMP Principal 

Liga:
	CBI PORTD, LED 
	RJMP Principal 

Atraso:
	DEC R3
	BRNE Atraso 
	DEC R2
	BRNE Atraso 
	RET