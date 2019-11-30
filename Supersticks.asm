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

    push Game.UI.GAME_MODE_1
    call Game.UI.View.Public.ShowGameModeSelectScreen
    call Keyboard.Public.ReadKey

    push Game.UI.GAME_MODE_2
    call Game.UI.View.Public.UpdateGameModeSelectScreen
    call Keyboard.Public.ReadKey

    push Game.UI.GAME_COMPLEXITY_1
    call Game.UI.View.Public.ShowGameComplexitySelectScreen
    call Keyboard.Public.ReadKey

    push Game.UI.GAME_COMPLEXITY_2
    call Game.UI.View.Public.UpdateGameComplexitySelectScreen
    call Keyboard.Public.ReadKey

    push Game.UI.GAME_COMPLEXITY_3
    call Game.UI.View.Public.UpdateGameComplexitySelectScreen
    call Keyboard.Public.ReadKey

    call Game.Public.Finalize
    ret

include 'Game\Game.public.asm'
include 'Game\Game.di.asm'
include 'Game\Game.du.asm'
