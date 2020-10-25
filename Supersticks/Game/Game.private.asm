; Parameters
;   Stack1 -- Pointer to TMatchState
;   Stack2 -- Pointer to TMatchConfiguration
;   Stack3 -- Pointer to function with player's 1 move
;   Stack4 -- Pointer to function with player's 2 move
; Returns
;   AH -- TRUE if player 1 wins, otherwise FALSE
Game.Private.Play:
    push bp
    mov bp, sp
    push bx

    mov bx, [bp + 4]

    push word [bp + 6]
    push bx
    call Game.UI.View.Public.ShowGameScreen

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
    sub [bx + Game.TMatchState.bCurrentSticksCount], ah
    not byte [bx + Game.TMatchState.bIsFirstPlayerTurn]

    push bx
    call Game.Logic.Public.IsGameOver

    cmp ax, TRUE
    je .GameOver

    push word [bp + 6]
    push bx
    call Game.UI.View.Public.UpdateGameScreen
    jmp .PlayerMove

.GameOver:
    mov ah, [bx + Game.TMatchState.bIsFirstPlayerTurn]

    pop bx
    pop bp
    ret 8

; Parameters
;   Stack1 -- Pointer to TMatchState
;   Stack2 -- Pointer to TMatchConfiguration
; Returns
;   AH -- Sticks count
Game.Private.GetComputerMove:
    call Keyboard.Public.ReadKey
    mov ah, 2
    ret 4

; Parameters
;   Stack1 -- Pointer to TMatchState
;   Stack2 -- Pointer to TMatchConfiguration
; Returns
;   AH -- Sticks count
Game.Private.GetUserMove:
    call Keyboard.Public.ReadKey
    mov ah, 1
    ret 4