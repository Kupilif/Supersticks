; Calling convention -- STDCALL
;   Argument-passing order
;       From last to first
;   Stack-maintenance responsibility
;       Called function pops its own arguments from the stack

    org 100h

include 'Game\Game.h.asm'

Start:
    call Game.Public.Initialize

    push Game.UI.GAME_MODE_1
    call Game.UI.View.Public.ShowGameModeSelectScreen

    call Keyboard.Public.ReadKey

    push Game.UI.GAME_MODE_2
    call Game.UI.View.Public.UpdateGameModeSelectScreen

    call Keyboard.Public.ReadKey

    call Game.Public.Finalize
    ret

include 'Game\Game.public.asm'
include 'Game\Game.di.asm'
include 'Game\Game.du.asm'
