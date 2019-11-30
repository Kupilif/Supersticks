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
;   aX -- array of X   

    org 100h

include 'Game\Game.h.asm'

Start:
    call Game.Public.Initialize

    call Game.UI.Public.SelectGameMode
    call Display.Public.Clear
    push 0xF
    push 0
    push 0
    push 1
    push ax
    call Display.Public.PrintNumber
    call Keyboard.Public.ReadKey

    call Game.UI.Public.SelectGameComplexity
    call Display.Public.Clear
    push 0xF
    push 0
    push 0
    push 1
    push ax
    call Display.Public.PrintNumber
    call Keyboard.Public.ReadKey

    call Game.Public.Finalize
    ret

include 'Game\Game.public.asm'
include 'Game\Game.di.asm'
include 'Game\Game.du.asm'
