; Parameters
;   Stack1 -- Pointer to TMatchState
;   Stack2 -- Pointer to TMatchConfiguration
;   Stack3 -- Pointer to function which gets 1st player move
;   Stack4 -- Pointer to function which gets 2nd player move
; Returns
;   AX -- TRUE if match should be continued, FALSE otherwise
Game.Private.PlayRound:
    push bp
    mov bp, sp
    push bx

    mov bx, [bp + 4]

    push word [bp + 6]
    push bx
    call Game.UI.Public.ShowMatch

.PlayerMove:
    push word [bp + 6]
    push bx
    cmp byte [bx + Game.TMatchState.bIsFirstPlayerTurn], TRUE
    jne .Player2Move

.Player1Move:
    call word [bp + 8]
    jmp .PlayerMoveEnd

.Player2Move:
    call word [bp + 10]

.PlayerMoveEnd:
    cmp ax, FALSE
    je .End

    sub [bx + Game.TMatchState.bCurrentSticksCount], al
    not byte [bx + Game.TMatchState.bIsFirstPlayerTurn]

    push bx
    call Game.Logic.Public.IsGameOver

    cmp ax, TRUE
    je .GameOver

    push word [bp + 6]
    push bx
    call Game.UI.Public.UpdateMatch
    jmp .PlayerMove

.GameOver:
    push bx
    call Game.Logic.Public.GetWinner
    mov [bx + Game.TMatchState.bIsFirstPlayerWin], al

    push word [bp + 6]
    push bx
    call Game.UI.Public.ShowRoundResult

    call Game.UI.Public.WaitForUser

    mov ax, TRUE

.End:
    pop bx
    pop bp
    ret 8

; Parameters
;   Stack1 -- Pointer to TMatchState
;   Stack2 -- Pointer to TMatchConfiguration
; Returns
;   AX -- Sticks count, FALSE if match was cancelled
Game.Private.GetComputerMove:
    push bp
    mov bp, sp
    push bx

    push word [bp + 6]
    push word [bp + 4]
    call Game.UI.Public.WaitForComputerMove

    cmp ax, FALSE
    je @F

    mov bx, [bp + 4]
    movzx ax, [bx + Game.TMatchState.bCurrentSticksCount]
    push ax
    call Game.Logic.Public.GetComputerMove

@@:
    pop bx
    pop bp
    ret 4

; Parameters
;   Stack1 -- Pointer to TMatchState
;   Stack2 -- Pointer to TMatchConfiguration
; Returns
;   AX -- Sticks count, FALSE if match was cancelled
Game.Private.GetUserMove:
    push bp
    mov bp, sp
    push cx
    
    .InputLoopStart:
        push word [bp + 6]
        push word [bp + 4]
        call Game.UI.Public.GetUserMove

        cmp ax, FALSE
        je .InputLoopEnd

        mov cx, ax
        push word [bp + 4]
        push ax
        call Game.Logic.Public.IsValidMove

        cmp ax, FALSE
        je .InputLoopStart

        mov ax, cx
    .InputLoopEnd:

    pop cx
    pop bp
    ret 4