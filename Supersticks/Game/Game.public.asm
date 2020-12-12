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
    cmp ax, FALSE
    je .ConfigurationCanceled
    mov [bx + Game.TMatchConfiguration.bMode], al
    cmp ax, Game.MODE_2
    je .ConfigurationSucceeded

.SelectGameComplexity:
    call Game.UI.Public.SelectGameComplexity
    cmp ax, FALSE
    je .SelectGameMode
    mov [bx + Game.TMatchConfiguration.bComplexity], al

.ConfigurationSucceeded:
    mov ax, TRUE
    jmp @F

.ConfigurationCanceled:

@@:
    pop bx
    pop bp
    ret 2

; Parameters
;   Stack1 -- Pointer to initialized TMatchConfiguration
Game.Public.StartMatch:
    push bp
    mov bp, sp
    push ax
    push bx
    push cx

    mov byte [Game.pTMatchState + Game.TMatchState.bIsFirstPlayerTurn], TRUE

    mov word [Game.pTMatchState + Game.TMatchState.wPlayer1Score], 0
    mov word [Game.pTMatchState + Game.TMatchState.wPlayer2Score], 0
    mov word [Game.pTMatchState + Game.TMatchState.pszPlayer1Name], Game.szPlayer1Name
    mov word [Game.pTMatchState + Game.TMatchState.pszPlayer2Name], Game.szPlayer2Name

    mov bx, [bp + 4]
    cmp byte [bx + Game.TMatchConfiguration.bMode], Game.MODE_1
    jne .UserVsUser

.ComputerVsUser:
    mov cx, Game.Private.GetComputerMove
    jmp .MatchLoopStart

.UserVsUser:
    mov cx, Game.Private.GetUserMove

.MatchLoopStart:
    mov byte [Game.pTMatchState + Game.TMatchState.bInitialSticksCount], 5
    mov byte [Game.pTMatchState + Game.TMatchState.bCurrentSticksCount], 5

    push cx
    push Game.Private.GetUserMove
    push word [bp + 4]
    push Game.pTMatchState
    call Game.Private.Play

    cmp ax, FALSE
    je .MatchLoopEnd

    cmp byte [Game.pTMatchState + Game.TMatchState.bIsFirstPlayerWin], TRUE
    jne @F
    inc word [Game.pTMatchState + Game.TMatchState.wPlayer1Score]
    jmp .MatchLoopStart
@@:
    inc word [Game.pTMatchState + Game.TMatchState.wPlayer2Score]
    jmp .MatchLoopStart
.MatchLoopEnd:

    pop cx
    pop bx
    pop ax
    pop bp
    ret 2

; Parameters
;   None
; Returns
;   AX -- TRUE if game exit confirmed. otherwise FALSE
Game.Public.ConfirmExit:
    call Game.UI.Public.ConfirmGameExit
    ret
