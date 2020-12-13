include 'Game\UI\View\Game.UI.View.public.asm'
include 'Game\UI\Controller\Game.UI.Controller.public.asm'
include 'Game\UI\Game.UI.private.asm'

; Parameters
;   None
; Returns
;   None
Game.UI.Public.Initialize:
    call Game.UI.View.Public.Initialize
    ret

; Parameters
;   None
; Returns
;   None
Game.UI.Public.Finalize:
    call Game.UI.View.Public.Finalize
    ret

; Parameter
;   None
; Returns
;   AX -- Selected game mode
Game.UI.Public.SelectGameMode:
    push Game.UI.View.Public.UpdateGameModeSelectScreen
    push Game.UI.View.Public.ShowGameModeSelectScreen
    push Game.MODE_COUNT
    push Game.UI.abGameModeSelectOptions
    call Game.UI.Private.SelectFromList
    ret

; Parameter
;   None
; Returns
;   AX -- Selected game mode
Game.UI.Public.SelectGameComplexity:
    push Game.UI.View.Public.UpdateGameComplexitySelectScreen
    push Game.UI.View.Public.ShowGameComplexitySelectScreen
    push Game.COMPLEXITY_COUNT
    push Game.UI.abGameComplexitySelectOptions
    call Game.UI.Private.SelectFromList
    ret

; Parameter
;   None
; Returns
;   AX -- TRUE when game should be continued, FALSE otherwise
Game.UI.Public.ShouldContinueGame:
    push Game.UI.View.Public.UpdateGameExitConfirmationScreen
    push Game.UI.View.Public.ShowGameExitConfirmationScreen
    push Game.UI.GAME_EXIT_CONFIRMATION_OPTION_COUNT
    push Game.UI.abGameExitConfirmationOptions
    call Game.UI.Private.SelectFromList
    ret

; Parameters
;   Stack1 -- Pointer to TMatchState
;   Stack2 -- Pointer to TMatchConfiguration
; Returns
;   None 
Game.UI.Public.ShowMatch:
    push bp
    mov bp, sp

    push word [bp + 6]
    push word [bp + 4]
    call Game.UI.View.Public.ShowGameScreen

    pop bp
    ret 4

; Parameters
;   Stack1 -- Pointer to TMatchState
;   Stack2 -- Pointer to TMatchConfiguration
; Returns
;   None 
Game.UI.Public.UpdateMatch:
    push bp
    mov bp, sp

    push word [bp + 6]
    push word [bp + 4]
    call Game.UI.View.Public.UpdateGameScreen

    pop bp
    ret 4

; Parameters
;   Stack1 -- Pointer to TMatchState
;   Stack2 -- Pointer to TMatchConfiguration
; Returns
;   None 
Game.UI.Public.ShowRoundResult:
    push bp
    mov bp, sp
    sub sp, 4
    push bx
    
.SelectColorScheme:
    mov bx, [bp + 6]

    cmp byte [bx + Game.TMatchConfiguration.bMode], Game.MODE_1
    jne @F

    mov word [bp - 2], Game.UI.View.ROUND_RESULT_SCREEN_MODE_1_PLAYER_1_WINNER_COLOR
    mov word [bp - 4], Game.UI.View.ROUND_RESULT_SCREEN_MODE_1_PLAYER_2_WINNER_COLOR
    jmp .ConfigureScreen
@@:
    mov word [bp - 2], Game.UI.View.ROUND_RESULT_SCREEN_MODE_2_PLAYER_1_WINNER_COLOR
    mov word [bp - 4], Game.UI.View.ROUND_RESULT_SCREEN_MODE_2_PLAYER_2_WINNER_COLOR

.ConfigureScreen:
    mov bx, [bp + 4]

    cmp byte [bx + Game.TMatchState.bIsFirstPlayerWin], TRUE
    jne @F

    push word [bp - 2]
    push word [bx + Game.TMatchState.pszPlayer1Name]
    jmp .ShowScreen
@@:
    push word [bp - 4]
    push word [bx + Game.TMatchState.pszPlayer2Name]

.ShowScreen:
    call Game.UI.View.Public.ShowRoundResultScreen

    pop bx
    mov sp, bp
    pop bp
    ret 4

; Parameters
;   Stack1 -- Pointer to TMatchState
;   Stack2 -- Pointer to TMatchConfiguration
; Returns
;   AX -- User move, FALSE if match was cancelled
Game.UI.Public.GetUserMove:
    push bp
    mov bp, sp

    push Game.UI.Controller.Public.GetUserMove
    push word [bp + 6]
    push word [bp + 4]
    call Game.UI.Private.GetGameActionFromUser

    pop bp
    ret 4

; Parameters
;   Stack1 -- Pointer to TMatchState
;   Stack2 -- Pointer to TMatchConfiguration
; Returns
;   AX -- FALSE if match was cancelled, TRUE otherwise
Game.UI.Public.WaitForComputerMove:
    push bp
    mov bp, sp

    push Game.UI.Controller.Public.WaitForAnyKey
    push word [bp + 6]
    push word [bp + 4]
    call Game.UI.Private.GetGameActionFromUser

    pop bp
    ret 4

; Parameters
;   None
; Returns
;   None
Game.UI.Public.WaitForUser:
    push ax

    call Game.UI.Controller.Public.WaitForAnyKey

    pop ax
    ret
