.nolist                     ; Desabilita a listagem no arquivo .lst (limpa o log de compilação)
.include "m328pdef.inc"     ; Inclui o arquivo com os nomes dos registradores do ATmega328P
.list                       ; Reabilita a listagem após a inclusão das definições

.equ LED = 5                ; Define o nome "LED" para o valor 5 (bit correspondente ao PB5)

.ORG 0x000                  ; Define que o código abaixo começa no endereço 0x000 da memória Flash
    RJMP INICIO             ; Salto relativo para o rótulo "INICIO" (pula o vetor de interrupções)

INICIO:
    ; --- Inicialização do Stack Pointer (Ponteiro de Pilha) ---
    LDI R16, LOW(RAMEND)    ; Carrega a parte baixa do endereço final da RAM no registrador R16
    OUT SPL, R16            ; Escreve R16 no registrador SPL (Stack Pointer Low)
    LDI R16, HIGH(RAMEND)   ; Carrega a parte alta do endereço final da RAM no registrador R16
    OUT SPH, R16            ; Escreve R16 no registrador SPH (Stack Pointer High)

    ; --- Configuração de Entrada e Saída ---
    LDI R16, 0xFF           ; Carrega o valor binário 11111111 (todo em nível alto) no R16
    OUT DDRB, R16           ; Configura o Data Direction Register do PORTB como tudo saída (1=saída)

PRINCIPAL:
    SBI PORTB, LED          ; (Set Bit in I/O) Coloca o bit 5 do PORTB em 1 (LIGA o LED)
    RCALL ATRASO            ; (Relative Call) Chama a sub-rotina de tempo, salva o retorno na pilha
    CBI PORTB, LED          ; (Clear Bit in I/O) Coloca o bit 5 do PORTB em 0 (DESLIGA o LED)
    RCALL ATRASO            ; Chama a sub-rotina de tempo novamente
    RJMP PRINCIPAL          ; (Relative Jump) Volta para o rótulo PRINCIPAL (loop infinito)

ATRASO:                     ; Início da sub-rotina de atraso (Delay)
    LDI R19, 20             ; Carrega R19 com 20 (contador do loop mais externo)
    LDI R18, 255            ; Carrega R18 com 255 (contador do loop intermediário)
    LDI R17, 255            ; Carrega R17 com 255 (contador do loop mais interno)

VOLTA:
    DEC R17                 ; Decrementa 1 de R17
    BRNE VOLTA              ; (Branch if Not Equal) Se R17 não for zero, volta para o rótulo VOLTA
    
    DEC R18                 ; Decrementa 1 de R18
    BRNE VOLTA              ; Se R18 não for zero, volta para VOLTA para reiniciar R17
    
    DEC R19                 ; Decrementa 1 de R19
    BRNE VOLTA              ; Se R19 não for zero, volta para VOLTA para reiniciar R18 e R17
    
    RET                     ; (Return) Retorna para a linha logo após onde o RCALL foi chamado
