include 'System\Display\Display.public.asm'
include 'Game\UI\View\Game.UI.View.private.asm'

Game.UI.View.Public.Initialize:
    call Display.Public.Initialize
    call Display.Public.Clear

    push Game.UI.View.GAME_SCREEN_STICKS_GAP
    push Game.UI.View.GAME_SCREEN_STICK_WIDTH
    push Game.UI.View.GAME_SCREEN_STICK_HEIGHT
    call Display.Public.ConfigureSticksSize
    ret

Game.UI.View.Public.Finalize:
    call Display.Public.Finalize
    ret

; Parameters
;   Stack1 -- Selected game mode
; Returns
;   None
Game.UI.View.Public.ShowGameModeSelectScreen:
    push bp
    mov bp, sp

    call Display.Public.Clear

    push Game.UI.View.GAME_MODE_SELECT_SCREEN_TITLE_COLOR
    push Game.UI.View.GAME_MODE_SELECT_SCREEN_TITLE_COLUMN
    push Game.UI.View.GAME_MODE_SELECT_SCREEN_TITLE_ROW
    push Game.UI.View.szTitle
    call Display.Public.PrintStringAtPosition

    push Game.UI.View.GAME_MODE_SELECT_SCREEN_MODE_1_COLOR
    push Game.UI.View.GAME_MODE_SELECT_SCREEN_MODE_1_COLUMN
    push Game.UI.View.GAME_MODE_SELECT_SCREEN_MODE_1_ROW
    push Game.UI.View.szGameMode1
    call Display.Public.PrintStringAtPosition

    push Game.UI.View.GAME_MODE_SELECT_SCREEN_MODE_2_COLOR
    push Game.UI.View.GAME_MODE_SELECT_SCREEN_MODE_2_COLUMN
    push Game.UI.View.GAME_MODE_SELECT_SCREEN_MODE_2_ROW
    push Game.UI.View.szGameMode2
    call Display.Public.PrintStringAtPosition

    push word [bp + 4]
    call Game.UI.View.Private.SetGameModeSelectScreenSelector

    pop bp
    ret 2

; Parameters
;   Stack1 -- Selected game mode
; Returns
;   None
Game.UI.View.Public.UpdateGameModeSelectScreen:
    push bp
    mov bp, sp

    push word [bp + 4]
    call Game.UI.View.Private.SetGameModeSelectScreenSelector

    pop bp
    ret 2

; Parameters
;   Stack1 -- Selected game complexity
; Returns
;   None
Game.UI.View.Public.ShowGameComplexitySelectScreen:
    push bp
    mov bp, sp

    call Display.Public.Clear

    push Game.UI.View.GAME_COMPLEXITY_SELECT_SCREEN_TITLE_COLOR
    push Game.UI.View.GAME_COMPLEXITY_SELECT_SCREEN_TITLE_COLUMN
    push Game.UI.View.GAME_COMPLEXITY_SELECT_SCREEN_TITLE_ROW
    push Game.UI.View.szTitle
    call Display.Public.PrintStringAtPosition

    push Game.UI.View.GAME_COMPLEXITY_SELECT_SCREEN_COMPLEXITY_1_COLOR
    push Game.UI.View.GAME_COMPLEXITY_SELECT_SCREEN_COMPLEXITY_1_COLUMN
    push Game.UI.View.GAME_COMPLEXITY_SELECT_SCREEN_COMPLEXITY_1_ROW
    push Game.UI.View.szGameComplexity1
    call Display.Public.PrintStringAtPosition

    push Game.UI.View.GAME_COMPLEXITY_SELECT_SCREEN_COMPLEXITY_2_COLOR
    push Game.UI.View.GAME_COMPLEXITY_SELECT_SCREEN_COMPLEXITY_2_COLUMN
    push Game.UI.View.GAME_COMPLEXITY_SELECT_SCREEN_COMPLEXITY_2_ROW
    push Game.UI.View.szGameComplexity2
    call Display.Public.PrintStringAtPosition

    push Game.UI.View.GAME_COMPLEXITY_SELECT_SCREEN_COMPLEXITY_3_COLOR
    push Game.UI.View.GAME_COMPLEXITY_SELECT_SCREEN_COMPLEXITY_3_COLUMN
    push Game.UI.View.GAME_COMPLEXITY_SELECT_SCREEN_COMPLEXITY_3_ROW
    push Game.UI.View.szGameComplexity3
    call Display.Public.PrintStringAtPosition

    push word [bp + 4]
    call Game.UI.View.Private.SetGameComplexitySelectScreenSelector

    pop bp
    ret 2

; Parameters
;   Stack1 -- Selected game complexity
; Returns
;   None
Game.UI.View.Public.UpdateGameComplexitySelectScreen:
    push bp
    mov bp, sp

    push word [bp + 4]
    call Game.UI.View.Private.SetGameComplexitySelectScreenSelector

    pop bp
    ret 2

; Parameters
;   Stack1 -- Selected option
; Returns
;   None
Game.UI.View.Public.ShowGameExitConfirmationScreen:
    push bp
    mov bp, sp

    call Display.Public.Clear

    push Game.UI.View.GAME_EXIT_CONFIRMATION_SCREEN_TITLE_COLOR
    push Game.UI.View.GAME_EXIT_CONFIRMATION_SCREEN_TITLE_COLUMN
    push Game.UI.View.GAME_EXIT_CONFIRMATION_SCREEN_TITLE_ROW
    push Game.UI.View.szGameExitConfirmation
    call Display.Public.PrintStringAtPosition

    push Game.UI.View.GAME_EXIT_CONFIRMATION_SCREEN_OPTION_1_COLOR
    push Game.UI.View.GAME_EXIT_CONFIRMATION_SCREEN_OPTION_1_COLUMN
    push Game.UI.View.GAME_EXIT_CONFIRMATION_SCREEN_OPTION_1_ROW
    push Game.UI.View.szGameExitConfirmationOption1
    call Display.Public.PrintStringAtPosition

    push Game.UI.View.GAME_EXIT_CONFIRMATION_SCREEN_OPTION_2_COLOR
    push Game.UI.View.GAME_EXIT_CONFIRMATION_SCREEN_OPTION_2_COLUMN
    push Game.UI.View.GAME_EXIT_CONFIRMATION_SCREEN_OPTION_2_ROW
    push Game.UI.View.szGameExitConfirmationOption2
    call Display.Public.PrintStringAtPosition

    push word [bp + 4]
    call Game.UI.View.Private.SetGameExitConfirmationScreenSelector

    pop bp
    ret 2

; Parameters
;   Stack1 -- Selected option
; Returns
;   None
Game.UI.View.Public.UpdateGameExitConfirmationScreen:
    push bp
    mov bp, sp

    push word [bp + 4]
    call Game.UI.View.Private.SetGameExitConfirmationScreenSelector

    pop bp
    ret 2

; Parameters
;   Stack1 -- Pointer to TMatchState
;   Stack2 -- Pointer to TMatchConfiguration
; Returns
;   None 
Game.UI.View.Public.ShowGameScreen:
    push bp
    mov bp, sp
    push bx
    push ax

    call Display.Public.Clear

    push Game.UI.View.GAME_SCREEN_SCORE_ROW_COLOR
    push Game.UI.View.GAME_SCREEN_SCORE_DELIMITER_COLUMN
    push Game.UI.View.GAME_SCREEN_SCORE_ROW
    push Game.UI.View.GAME_SCREEN_SCORE_DELIMITER_SYMBOL
    call Display.Public.PrintCharacter

    push Game.UI.View.GAME_SCREEN_SCORE_ROW_COLOR
    push Game.UI.View.GAME_SCREEN_SCORE_DELIMITER_COLUMN + 1
    push Game.UI.View.GAME_SCREEN_SCORE_ROW
    push Game.UI.View.GAME_SCREEN_SCORE_DELIMITER_SYMBOL
    call Display.Public.PrintCharacter

    mov bx, [bp + 4]

    push Game.UI.View.GAME_SCREEN_SCORE_ROW_COLOR
    push Game.UI.View.GAME_SCREEN_PLAYER_1_SCORE_COLUMN
    push Game.UI.View.GAME_SCREEN_SCORE_ROW
    push Game.UI.View.GAME_SCREEN_SCORE_DIGITS_AMOUNT
    push word [bx + Game.TMatchState.wPlayer1Score]
    call Display.Public.PrintNumber

    push Game.UI.View.GAME_SCREEN_SCORE_ROW_COLOR
    push Game.UI.View.GAME_SCREEN_PLAYER_2_SCORE_COLUMN
    push Game.UI.View.GAME_SCREEN_SCORE_ROW
    push Game.UI.View.GAME_SCREEN_SCORE_DIGITS_AMOUNT
    push word [bx + Game.TMatchState.wPlayer2Score]
    call Display.Public.PrintNumber

    push Game.UI.View.GAME_SCREEN_SCORE_ROW_COLOR
    push Game.UI.View.GAME_SCREEN_PLAYER_1_NAME_COLUMN
    push Game.UI.View.GAME_SCREEN_SCORE_ROW
    push word [bx + Game.TMatchState.pszPlayer1Name]
    call Display.Public.PrintStringAtPosition

    push Game.UI.View.GAME_SCREEN_SCORE_ROW_COLOR
    push Game.UI.View.GAME_SCREEN_PLAYER_2_NAME_COLUMN
    push Game.UI.View.GAME_SCREEN_SCORE_ROW
    push word [bx + Game.TMatchState.pszPlayer2Name]
    call Display.Public.PrintStringAtPosition

    push word [bp + 4]
    call Game.UI.View.Private.SetTurnMarker

    xor ax, ax
    mov al, [bx + Game.TMatchState.bInitialSticksCount]
    push ax 
    call Display.Public.ConfigureSticksPosition

    push word [bp + 6]
    call Game.UI.View.Private.GetSticksColor

    push ax
    xor ax, ax
    mov al, [bx + Game.TMatchState.bCurrentSticksCount]
    push ax
    call Display.Public.DrawSticks

    pop ax
    pop bx
    pop bp
    ret 4

; Parameters
;   Stack1 -- Pointer to TMatchState
;   Stack2 -- Pointer to TMatchConfiguration
; Returns
;   None 
Game.UI.View.Public.UpdateGameScreen:
    push bp
    mov bp, sp
    push bx
    push ax

    push word [bp + 4]
    call Game.UI.View.Private.SetTurnMarker

    push word [bp + 6]
    call Game.UI.View.Private.GetSticksColor

    push ax
    xor ax, ax
    mov bx, [bp + 4]
    mov al, [bx + Game.TMatchState.bCurrentSticksCount]
    push ax
    call Display.Public.DrawSticks

    pop ax
    pop bx
    pop bp
    ret 4

; Parameters
;   Stack1 -- Player name
;   Stack2 -- Color
; Returns
;   None 
Game.UI.View.Public.ShowRoundResultScreen:
    push bp
    mov bp, sp

    call Display.Public.Clear

    push word [bp + 6]
    push Game.UI.View.ROUND_RESULT_SCREEN_WINNER_COLUMN
    push Game.UI.View.ROUND_RESULT_SCREEN_WINNER_ROW
    push word [bp + 4]
    call Display.Public.PrintStringAtPosition

    push word [bp + 6]
    push Game.UI.View.szRoundWinner
    call Display.Public.PrintString

    pop bp
    ret 4
