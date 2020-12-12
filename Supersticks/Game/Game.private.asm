; Parameters
;   Stack1 -- Pointer to TMatchState
;   Stack2 -- Pointer to TMatchConfiguration
;   Stack3 -- Pointer to function with player's 1 move
;   Stack4 -- Pointer to function with player's 2 move
; Returns
;   AX -- TRUE if match should be continued, FALSE otherwise
Game.Private.Play:
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
    mov al, [bx + Game.TMatchState.bIsFirstPlayerTurn]
    mov [bx + Game.TMatchState.bIsFirstPlayerWin], al
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
    push word [bp + 6]
    push word [bp + 4]
    call Game.UI.Public.WaitForUser

    cmp ax, FALSE
    je @F

    mov ax, 1

@@:
    ret 4

; Parameters
;   Stack1 -- Pointer to TMatchState
;   Stack2 -- Pointer to TMatchConfiguration
; Returns
;   AX -- Sticks count, FALSE if match was cancelled
Game.Private.GetUserMove:
    push word [bp + 6]
    push word [bp + 4]
    call Game.UI.Public.GetUserMove

    ret 4