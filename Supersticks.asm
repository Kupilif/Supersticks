; Calling convention -- STDCALL
;   Argument-passing order
;       From last to first
;   Stack-maintenance responsibility
;       Called function pops its own arguments from the stack

    org 100h

include 'Game\Game.h.asm'

Start:
    call Game.Public.Initialize

    push 4
    call Game.UI.Public.ConfigureGameScreen

    push Game.UI.STICKS_COLOR_EASY_LEVEL
    push 4
    call Display.Public.DrawSticks
    call Keyboard.Public.ReadKey

    push Game.UI.STICKS_COLOR_MEDIUM_LEVEL
    push 3
    call Display.Public.DrawSticks
    call Keyboard.Public.ReadKey

    push Game.UI.STICKS_COLOR_HARD_LEVEL
    push 2
    call Display.Public.DrawSticks
    call Keyboard.Public.ReadKey

    push Game.UI.STICKS_COLOR_TWO_PLAYERS
    push 1
    call Display.Public.DrawSticks
    call Keyboard.Public.ReadKey

    call Game.Public.Finalize
    ret

include 'Game\Game.public.asm'
include 'Game\Game.di.asm'
include 'Game\Game.du.asm'
