; Parameters
;   Stack1 -- Selected game mode
; Returns
;   None
Game.UI.View.Private.SetGameModeSelector:
    push bp
    mov bp, sp

    push Game.UI.View.SELECTOR_COLOR
    push Game.UI.View.GAME_MODE_SELECT_SCREEN_MODE_1_SELECTOR_COLUMN
    push Game.UI.View.GAME_MODE_SELECT_SCREEN_MODE_1_ROW
    cmp word [bp + 4], Game.UI.GAME_MODE_1
    je .Game.UI.View.Public.SetGameModeSelector.SelectedMode1
    push Game.UI.View.SYMBOL_CLEAR
    jmp @F
.Game.UI.View.Public.SetGameModeSelector.SelectedMode1:
    push Game.UI.View.SELECTOR_SYMBOL
@@:
    call Display.Public.PrintCharacter

    push Game.UI.View.SELECTOR_COLOR
    push Game.UI.View.GAME_MODE_SELECT_SCREEN_MODE_2_SELECTOR_COLUMN
    push Game.UI.View.GAME_MODE_SELECT_SCREEN_MODE_2_ROW
    cmp word [bp + 4], Game.UI.GAME_MODE_2
    je .Game.UI.View.Public.SetGameModeSelector.SelectedMode2
    push Game.UI.View.SYMBOL_CLEAR
    jmp @F
.Game.UI.View.Public.SetGameModeSelector.SelectedMode2:
    push Game.UI.View.SELECTOR_SYMBOL
@@:
    call Display.Public.PrintCharacter

    pop bp
    ret 2