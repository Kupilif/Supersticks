; Calling convention -- STDCALL
;   Argument-passing order
;       From last to first
;   Stack-maintenance responsibility
;       Called function pops its own arguments from the stack
;
; Identifier naming convention -- Hungarian notation
;   b -- byte
;   w -- word
;   sz -- zero-terminated string
;   T -- type
;   aXxx -- array of Xxx
;   pXxx -- pointer to Xxx

    org 100h

include 'Game\Game.h.asm'

TRUE = 0
FALSE = 255

Supersticks:
    call Game.Public.Initialize

.ConfigureMatch:
    push pTMatchConfiguration
    call Game.Public.ConfigureMatch
    cmp ax, FALSE
    je .ConfirmExit

.PlayMatch:
    push pTMatchConfiguration
    call Game.Public.PlayMatch
    jmp .ConfigureMatch

.ConfirmExit:
    call Game.Public.ShouldContinueGame
    cmp ax, TRUE
    je .ConfigureMatch

    call Game.Public.Finalize
    ret

include 'Game\Game.public.asm'
include 'Game\Game.di.asm'
include 'Game\Game.du.asm'

pTMatchConfiguration rb Game.TMatchConfiguration.SIZE_BYTES
