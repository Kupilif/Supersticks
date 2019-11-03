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
    je .SelectedMode1
    push Game.UI.View.SYMBOL_CLEAR
    jmp @F
.SelectedMode1:
    push Game.UI.View.SELECTOR_SYMBOL
@@:
    call Display.Public.PrintCharacter

    push Game.UI.View.SELECTOR_COLOR
    push Game.UI.View.GAME_MODE_SELECT_SCREEN_MODE_2_SELECTOR_COLUMN
    push Game.UI.View.GAME_MODE_SELECT_SCREEN_MODE_2_ROW
    cmp word [bp + 4], Game.UI.GAME_MODE_2
    je .SelectedMode2
    push Game.UI.View.SYMBOL_CLEAR
    jmp @F
.SelectedMode2:
    push Game.UI.View.SELECTOR_SYMBOL
@@:
    call Display.Public.PrintCharacter

    pop bp
    ret 2

; Parameters
;   Stack1 -- Selected game complexity
; Returns
;   None
Game.UI.View.Private.SetGameComplexitySelector:
    push bp
    mov bp, sp

    push Game.UI.View.SELECTOR_COLOR
    push Game.UI.View.GAME_COMPLEXITY_SELECT_SCREEN_COMPLEXITY_1_SELECTOR_COLUMN
    push Game.UI.View.GAME_COMPLEXITY_SELECT_SCREEN_COMPLEXITY_1_ROW
    cmp word [bp + 4], Game.UI.GAME_COMPLEXITY_1
    je .SelectedComplexity1
    push Game.UI.View.SYMBOL_CLEAR
    jmp @F
.SelectedComplexity1:
    push Game.UI.View.SELECTOR_SYMBOL
@@:
    call Display.Public.PrintCharacter

    push Game.UI.View.SELECTOR_COLOR
    push Game.UI.View.GAME_COMPLEXITY_SELECT_SCREEN_COMPLEXITY_2_SELECTOR_COLUMN
    push Game.UI.View.GAME_COMPLEXITY_SELECT_SCREEN_COMPLEXITY_2_ROW
    cmp word [bp + 4], Game.UI.GAME_COMPLEXITY_2
    je .SelectedComplexity2
    push Game.UI.View.SYMBOL_CLEAR
    jmp @F
.SelectedComplexity2:
    push Game.UI.View.SELECTOR_SYMBOL
@@:
    call Display.Public.PrintCharacter

    push Game.UI.View.SELECTOR_COLOR
    push Game.UI.View.GAME_COMPLEXITY_SELECT_SCREEN_COMPLEXITY_3_SELECTOR_COLUMN
    push Game.UI.View.GAME_COMPLEXITY_SELECT_SCREEN_COMPLEXITY_3_ROW
    cmp word [bp + 4], Game.UI.GAME_COMPLEXITY_3
    je .SelectedComplexity3
    push Game.UI.View.SYMBOL_CLEAR
    jmp @F
.SelectedComplexity3:
    push Game.UI.View.SELECTOR_SYMBOL
@@:
    call Display.Public.PrintCharacter

    pop bp
    ret 2
