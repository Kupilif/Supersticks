include 'Game\UI\View\Game.UI.View.public.asm'
include 'Game\UI\Controller\Game.UI.Controller.public.asm'
include 'Game\UI\Game.UI.private.asm'

Game.UI.Public.Initialize:
    call Game.UI.View.Public.Initialize
    ret

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
;   AX -- User move, FALSE if match was cancelled
Game.UI.Public.GetUserMove:
    push bp
    mov bp, sp

    push Game.UI.Controller.Public.GetUserMove
    push word [bp + 6]
    push word [bp + 4]
    call Game.UI.Private.GetUserInput

    pop bp
    ret 4

; Parameters
;   Stack1 -- Pointer to TMatchState
;   Stack2 -- Pointer to TMatchConfiguration
; Returns
;   AX -- FALSE if ESC was pressed, TRUE otherwise
Game.UI.Public.WaitForUser:
    push bp
    mov bp, sp

    push Game.UI.Controller.Public.WaitForAnyKey
    push word [bp + 6]
    push word [bp + 4]
    call Game.UI.Private.GetUserInput

    pop bp
    ret 4
