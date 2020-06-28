include 'Game\Logic\Game.Logic.public.asm'
include 'Game\UI\Game.UI.public.asm'
include 'Game\Game.private.asm'

Game.Public.Initialize:
    call Game.UI.Public.Initialize
    call Game.Logic.Public.Initialize
    ret

Game.Public.Finalize:
    call Game.UI.Public.Finalize
    ret

; Parameters
;   Stack1 -- Pointer to TMatchConfiguration
; Returns
;   AX -- TRUE if match configuration was written to specified TMatchConfiguration, otherwise FALSE
Game.Public.ConfigureMatch:
    push bp
    mov bp, sp
    push bx

    mov bx, [bp + 4]

.SelectGameMode:
    call Game.UI.Public.SelectGameMode
    cmp ax, Game.CANCEL_ACTION
    je .ConfigurationCanceled
    mov [bx + Game.TMatchConfiguration.Mode], al
    cmp ax, Game.MODE_2
    je .ConfigurationSucceeded

.SelectGameComplexity:
    call Game.UI.Public.SelectGameComplexity
    cmp ax, Game.CANCEL_ACTION
    je .SelectGameMode
    mov [bx + Game.TMatchConfiguration.Complexity], al

.ConfigurationSucceeded:
    mov ax, TRUE
    jmp @F

.ConfigurationCanceled:
    mov ax, FALSE

@@:
    pop bx
    pop bp
    ret 2

; Parameters
;   Stack1 -- Pointer to initialized TMatchConfiguration
Game.Public.StartMatch:
    push bp
    mov bp, sp

    mov byte [Game.pTMatchState + Game.TMatchState.InitialSticksCount], 5
    mov byte [Game.pTMatchState + Game.TMatchState.CurrentSticksCount], 5
    mov byte [Game.pTMatchState + Game.TMatchState.IsFirstPlayerTurn], TRUE
    mov word [Game.pTMatchState + Game.TMatchState.Player1Score], 12
    mov word [Game.pTMatchState + Game.TMatchState.Player2Score], 27
    mov word [Game.pTMatchState + Game.TMatchState.Player1Name], Game.szPlayer1Name
    mov word [Game.pTMatchState + Game.TMatchState.Player2Name], Game.szPlayer2Name

    push word [bp + 4]
    push Game.pTMatchState
    call Game.UI.View.Public.ShowGameScreen
    call Keyboard.Public.ReadKey

    mov byte [Game.pTMatchState + Game.TMatchState.CurrentSticksCount], 4
    mov byte [Game.pTMatchState + Game.TMatchState.IsFirstPlayerTurn], FALSE
    push word [bp + 4]
    push Game.pTMatchState
    call Game.UI.View.Public.UpdateGameScreen
    call Keyboard.Public.ReadKey

    mov byte [Game.pTMatchState + Game.TMatchState.CurrentSticksCount], 3
    mov byte [Game.pTMatchState + Game.TMatchState.IsFirstPlayerTurn], TRUE
    push word [bp + 4]
    push Game.pTMatchState
    call Game.UI.View.Public.UpdateGameScreen
    call Keyboard.Public.ReadKey

    mov byte [Game.pTMatchState + Game.TMatchState.CurrentSticksCount], 2
    mov byte [Game.pTMatchState + Game.TMatchState.IsFirstPlayerTurn], FALSE
    push word [bp + 4]
    push Game.pTMatchState
    call Game.UI.View.Public.UpdateGameScreen
    call Keyboard.Public.ReadKey

    mov byte [Game.pTMatchState + Game.TMatchState.CurrentSticksCount], 1
    mov byte [Game.pTMatchState + Game.TMatchState.IsFirstPlayerTurn], TRUE
    push word [bp + 4]
    push Game.pTMatchState
    call Game.UI.View.Public.UpdateGameScreen
    call Keyboard.Public.ReadKey

    pop bp
    ret 2

; Parameters
;   None
; Returns
;   AX -- TRUE if game exit confirmed. otherwise FALSE
Game.Public.ConfirmExit:
    call Game.UI.Public.ConfirmGameExit
    cmp ax, Game.GAME_EXIT_CONFIRMATION_OPTION_1
    jne .ExitNotConfirmed

.ExitConfirmed:
    mov ax, TRUE
    jmp @F

.ExitNotConfirmed:
    mov ax, FALSE
@@:
    ret
