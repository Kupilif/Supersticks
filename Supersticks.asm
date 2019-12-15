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

Supersticks:
    call Game.Public.Initialize

.ConfigureMatch:
    push pTMatchConfiguration
    call Game.Public.ConfigureMatch
    cmp ax, Game.FALSE
    je .End

.StartMatch:
    push pTMatchConfiguration
    call Game.Public.StartMatch
    jmp .ConfigureMatch

.End:
    call Game.Public.Finalize
    ret

include 'Game\Game.public.asm'
include 'Game\Game.di.asm'
include 'Game\Game.du.asm'

pTMatchConfiguration rb Game.TMatchConfiguration_SIZE_BYTES
