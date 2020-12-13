include 'Game\Logic\Game.Logic.public.asm'
include 'Game\UI\Game.UI.public.asm'
include 'Game\Game.private.asm'

Game.Public.Initialize:
    call Game.UI.Public.Initialize
    call Game.Logic.Public.InitializeOnce
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
    je .ConfigurationCancelled

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

.ConfigurationCancelled:
    pop bx
    pop bp
    ret 2

; Parameters
;   Stack1 -- Pointer to initialized TMatchConfiguration
; Returns
;   None
Game.Public.PlayMatch:
    push bp
    mov bp, sp
    push ax
    push bx
    push cx

    push word [bp + 4]
    call Game.Logic.Public.Initialize

    mov word [Game.pTMatchState + Game.TMatchState.wPlayer1Score], 0
    mov word [Game.pTMatchState + Game.TMatchState.wPlayer2Score], 0

    mov bx, [bp + 4]
    cmp byte [bx + Game.TMatchConfiguration.bMode], Game.MODE_1
    jne .UserVsUser

.ComputerVsUser:
    mov cx, Game.Private.GetComputerMove
    mov word [Game.pTMatchState + Game.TMatchState.pszPlayer1Name], Game.szMode1Player1Name
    mov word [Game.pTMatchState + Game.TMatchState.pszPlayer2Name], Game.szMode1Player2Name
    jmp .MatchLoopStart

.UserVsUser:
    mov cx, Game.Private.GetUserMove
    mov word [Game.pTMatchState + Game.TMatchState.pszPlayer1Name], Game.szMode2Player1Name
    mov word [Game.pTMatchState + Game.TMatchState.pszPlayer2Name], Game.szMode2Player2Name

    .MatchLoopStart:
        call Game.Logic.Public.DoesPlayer1StartRound
        mov [Game.pTMatchState + Game.TMatchState.bIsFirstPlayerTurn], al

        call Game.Logic.Public.GetSticksCount
        mov [Game.pTMatchState + Game.TMatchState.bInitialSticksCount], al
        mov [Game.pTMatchState + Game.TMatchState.bCurrentSticksCount], al

        push cx
        push Game.Private.GetUserMove
        push word [bp + 4]
        push Game.pTMatchState
        call Game.Private.PlayRound

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
;   AX -- TRUE when game should be continued, FALSE otherwise
Game.Public.ShouldContinueGame:
    call Game.UI.Public.ShouldContinueGame
    ret
