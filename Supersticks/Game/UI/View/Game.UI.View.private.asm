; Parameters
;   Stack1 -- Selected game mode
; Returns
;   None
Game.UI.View.Private.SetGameModeSelectScreenSelector:
    push bp
    mov bp, sp

    push Game.UI.View.SELECTOR_COLOR
    push Game.UI.View.GAME_MODE_SELECT_SCREEN_MODE_1_SELECTOR_COLUMN
    push Game.UI.View.GAME_MODE_SELECT_SCREEN_MODE_1_ROW
    cmp word [bp + 4], Game.MODE_1
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
    cmp word [bp + 4], Game.MODE_2
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
Game.UI.View.Private.SetGameComplexitySelectScreenSelector:
    push bp
    mov bp, sp

    push Game.UI.View.SELECTOR_COLOR
    push Game.UI.View.GAME_COMPLEXITY_SELECT_SCREEN_COMPLEXITY_1_SELECTOR_COLUMN
    push Game.UI.View.GAME_COMPLEXITY_SELECT_SCREEN_COMPLEXITY_1_ROW
    cmp word [bp + 4], Game.COMPLEXITY_1
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
    cmp word [bp + 4], Game.COMPLEXITY_2
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
    cmp word [bp + 4], Game.COMPLEXITY_3
    je .SelectedComplexity3
    push Game.UI.View.SYMBOL_CLEAR
    jmp @F
.SelectedComplexity3:
    push Game.UI.View.SELECTOR_SYMBOL
@@:
    call Display.Public.PrintCharacter

    pop bp
    ret 2

; Parameters
;   Stack1 -- Selected option
; Returns
;   None
Game.UI.View.Private.SetGameExitConfirmationScreenSelector:
    push bp
    mov bp, sp

    push Game.UI.View.SELECTOR_COLOR
    push Game.UI.View.GAME_EXIT_CONFIRMATION_SCREEN_OPTION_1_SELECTOR_COLUMN
    push Game.UI.View.GAME_EXIT_CONFIRMATION_SCREEN_OPTION_1_ROW
    cmp word [bp + 4], Game.GAME_EXIT_CONFIRMATION_OPTION_1
    je .SelectedOption1
    push Game.UI.View.SYMBOL_CLEAR
    jmp @F
.SelectedOption1:
    push Game.UI.View.SELECTOR_SYMBOL
@@:
    call Display.Public.PrintCharacter

    push Game.UI.View.SELECTOR_COLOR
    push Game.UI.View.GAME_EXIT_CONFIRMATION_SCREEN_OPTION_2_SELECTOR_COLUMN
    push Game.UI.View.GAME_EXIT_CONFIRMATION_SCREEN_OPTION_2_ROW
    cmp word [bp + 4], Game.GAME_EXIT_CONFIRMATION_OPTION_2
    je .SelectedOption2
    push Game.UI.View.SYMBOL_CLEAR
    jmp @F
.SelectedOption2:
    push Game.UI.View.SELECTOR_SYMBOL
@@:
    call Display.Public.PrintCharacter

    pop bp
    ret 2

; Parameters
;   Stack1 -- Pointer to TMatchConfiguration
; Returns
;   AX -- Sticks color
Game.UI.View.Private.GetSticksColor:
    push bp
    mov bp, sp
    push bx
    push dx

    mov bx, [bp + 4]
    cmp byte [bx + Game.TMatchConfiguration.bMode], Game.MODE_2
    jne @F
    mov ax, Game.UI.View.GAME_SCREEN_STICKS_COLOR_TWO_PLAYERS
    jmp .ColorSelected

@@:
    mov dl, [bx + Game.TMatchConfiguration.bComplexity]
    cmp dl, Game.COMPLEXITY_1
    jne @F
    mov ax, Game.UI.View.GAME_SCREEN_STICKS_COLOR_COMPLEXITY_1
    jmp .ColorSelected
@@:
    cmp dl, Game.COMPLEXITY_2
    jne @F
    mov ax, Game.UI.View.GAME_SCREEN_STICKS_COLOR_COMPLEXITY_2
    jmp .ColorSelected
@@:
    mov ax, Game.UI.View.GAME_SCREEN_STICKS_COLOR_COMPLEXITY_3

.ColorSelected:
    pop dx
    pop bx
    pop bp
    ret 2

; Parameters
;   Stack1 -- Pointer to TMatchState
; Returns
;   None
Game.UI.View.Private.SetTurnMarker:
    push bp
    mov bp, sp
    push bx

    mov bx, [bp + 4]
    cmp byte [bx + Game.TMatchState.bIsFirstPlayerTurn], TRUE
    jne .Player2Turn

.Player1Turn:
    push Game.UI.View.GAME_SCREEN_TURN_MARKER_COLOR
    push Game.UI.View.GAME_SCREEN_PLAYER_1_TURN_MARKER_COLUMN
    push Game.UI.View.GAME_SCREEN_SCORE_ROW
    push Game.UI.View.GAME_SCREEN_PLAYER_1_TURN_MARKER
    call Display.Public.PrintCharacter

    push Game.UI.View.GAME_SCREEN_TURN_MARKER_COLOR
    push Game.UI.View.GAME_SCREEN_PLAYER_2_TURN_MARKER_COLUMN
    push Game.UI.View.GAME_SCREEN_SCORE_ROW
    push Game.UI.View.SYMBOL_CLEAR
    call Display.Public.PrintCharacter

    jmp @F

.Player2Turn:
    push Game.UI.View.GAME_SCREEN_TURN_MARKER_COLOR
    push Game.UI.View.GAME_SCREEN_PLAYER_1_TURN_MARKER_COLUMN
    push Game.UI.View.GAME_SCREEN_SCORE_ROW
    push Game.UI.View.SYMBOL_CLEAR
    call Display.Public.PrintCharacter

    push Game.UI.View.GAME_SCREEN_TURN_MARKER_COLOR
    push Game.UI.View.GAME_SCREEN_PLAYER_2_TURN_MARKER_COLUMN
    push Game.UI.View.GAME_SCREEN_SCORE_ROW
    push Game.UI.View.GAME_SCREEN_PLAYER_2_TURN_MARKER
    call Display.Public.PrintCharacter

@@:
    pop bx
    pop bp
    ret 2
