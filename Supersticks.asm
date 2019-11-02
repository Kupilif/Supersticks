; Calling convention -- STDCALL
;   Argument-passing order
;       From last to first
;   Stack-maintenance responsibility
;       Called function pops its own arguments from the stack

    org 100h

include 'Game\Game.h.asm'

Start:
    call Game.Public.Initialize

    push Game.UI.COLOR_TITLE
    push 15
    push 1
    push Game.UI.sTitle
    call Display.Public.PrintString

    push Game.UI.COLOR_STICKS_EASY_LEVEL
    push 1
    push 3
    push 0
    push 12
    call Display.Public.PrintNumber

    push Game.UI.COLOR_STICKS_EASY_LEVEL
    push 1
    push 4
    push 5
    push 12
    call Display.Public.PrintNumber

    push Game.UI.COLOR_STICKS_EASY_LEVEL
    push 1
    push 5
    push 0
    push -12
    call Display.Public.PrintNumber

    push Game.UI.COLOR_STICKS_EASY_LEVEL
    push 1
    push 6
    push 5
    push -12
    call Display.Public.PrintNumber

    push Game.UI.COLOR_STICKS_EASY_LEVEL
    push 1
    push 7
    push 0
    push 0
    call Display.Public.PrintNumber

    push Game.UI.COLOR_STICKS_EASY_LEVEL
    push 1
    push 8
    push 10
    push 0
    call Display.Public.PrintNumber

    push Game.UI.COLOR_STICKS_EASY_LEVEL
    push 1
    push 9
    push 3
    push 32767
    call Display.Public.PrintNumber

    push Game.UI.COLOR_STICKS_EASY_LEVEL
    push 1
    push 10
    push 5
    push 32767
    call Display.Public.PrintNumber

    push Game.UI.COLOR_STICKS_EASY_LEVEL
    push 1
    push 11
    push 20
    push 32768
    call Display.Public.PrintNumber

    push Game.UI.COLOR_STICKS_EASY_LEVEL
    push 1
    push 12
    push 0
    push 65535
    call Display.Public.PrintNumber

    call Keyboard.Public.ReadKey

    call Display.Public.Clear

    push 4
    call Game.UI.Public.ConfigureGameScreen

    push Game.UI.COLOR_STICKS_EASY_LEVEL
    push 4
    call Display.Public.DrawSticks
    call Keyboard.Public.ReadKey

    push Game.UI.COLOR_STICKS_MEDIUM_LEVEL
    push 3
    call Display.Public.DrawSticks
    call Keyboard.Public.ReadKey

    push Game.UI.COLOR_STICKS_HARD_LEVEL
    push 2
    call Display.Public.DrawSticks
    call Keyboard.Public.ReadKey

    push Game.UI.COLOR_STICKS_TWO_PLAYERS
    push 1
    call Display.Public.DrawSticks
    call Keyboard.Public.ReadKey

    call Game.Public.Finalize
    ret

include 'Game\Game.public.asm'
include 'Game\Game.di.asm'
include 'Game\Game.du.asm'
