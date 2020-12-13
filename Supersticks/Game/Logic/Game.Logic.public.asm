include 'Utils\Random\Random.public.asm'
include 'Game\Logic\Game.Logic.private.asm'

Game.Logic.Public.InitializeOnce:
    call Random.Public.Initialize
    ret

; Parameters
;   Stack1 -- Pointer to initialized TMatchConfiguration
; Returns
;   None
Game.Logic.Public.Initialize:
    push bp
    mov bp, sp
    push bx

    mov bx, [bp + 4]
    cmp byte [bx + Game.TMatchConfiguration.bMode], Game.MODE_1
    jne .UserVsUser

.ComputerVsUser:
    cmp byte [bx + Game.TMatchConfiguration.bComplexity], Game.COMPLEXITY_1
    jne @F
    mov word [Game.Logic.wPlayer1StartsRoundProbability], Game.Logic.COMPLEXITY_1_PLAYER_1_STARTS_ROUND_PROBABILITY
    mov word [Game.Logic.wComputerMakesCorrectMoveProbability], Game.Logic.COMPLEXITY_1_COMPUTER_MAKES_CORRECT_MOVE_PROBABILITY
    jmp .End

@@:
    cmp byte [bx + Game.TMatchConfiguration.bComplexity], Game.COMPLEXITY_2
    jne @F
    mov word [Game.Logic.wPlayer1StartsRoundProbability], Game.Logic.COMPLEXITY_2_PLAYER_1_STARTS_ROUND_PROBABILITY
    mov word [Game.Logic.wComputerMakesCorrectMoveProbability], Game.Logic.COMPLEXITY_2_COMPUTER_MAKES_CORRECT_MOVE_PROBABILITY
    jmp .End

@@:
    mov word [Game.Logic.wPlayer1StartsRoundProbability], Game.Logic.COMPLEXITY_3_PLAYER_1_STARTS_ROUND_PROBABILITY
    mov word [Game.Logic.wComputerMakesCorrectMoveProbability], Game.Logic.COMPLEXITY_3_COMPUTER_MAKES_CORRECT_MOVE_PROBABILITY
    jmp .End

.UserVsUser:
    mov word [Game.Logic.wPlayer1StartsRoundProbability], Game.Logic.COMPLEXITY_NONE_PLAYER_1_START_ROUND_PROBABILITY
    mov word [Game.Logic.wComputerMakesCorrectMoveProbability], Game.Logic.COMPLEXITY_NONE_COMPUTER_MAKES_CORRECT_MOVE_PROBABILITY

.End:
    pop bx
    pop bp
    ret 2

; Parameters
;   None
; Returns
;   AX -- TRUE if player 1 starts round, FALSE otherwise
Game.Logic.Public.DoesPlayer1StartRound:
    push Game.Logic.MAX_PROBABILITY
    call Random.Public.Get

    cmp ax, [Game.Logic.wPlayer1StartsRoundProbability]
    jae @F

    mov ax, TRUE
    jmp .End
@@:
    mov ax, FALSE

.End:
    ret

; Parameters
;   None
; Returns
;   AX -- Sticks count
Game.Logic.Public.GetSticksCount:
    push Game.Logic.MAX_STICKS_COUNT - Game.Logic.MIN_STICKS_COUNT + 1
    call Random.Public.Get
    add ax, Game.Logic.MIN_STICKS_COUNT
    ret

; Parameters
;   Stack1 -- Current sticks count
; Returns
;   AX -- Sticks count
Game.Logic.Public.GetComputerMove:
    push bp
    mov bp, sp

    push Game.Logic.MAX_PROBABILITY
    call Random.Public.Get

    cmp ax, [Game.Logic.wComputerMakesCorrectMoveProbability]
    jae .RandomMove

.CorrectMove:
    push word [bp + 4]
    call Game.Logic.Private.HowMuchSticksTakeToWin

    test ax, ax
    jz .RandomMove
    jmp .End

.RandomMove:
    mov ax, Game.Logic.MAX_STICKS_COUNT_PER_MOVE
    cmp ax, [bp + 4]
    jbe @F
    mov ax, [bp + 4]
@@:    
    add ax, 1 - Game.Logic.MIN_STICKS_COUNT_PER_MOVE

    push ax
    call Random.Public.Get

    add ax, Game.Logic.MIN_STICKS_COUNT_PER_MOVE

.End:
    pop bp
    ret 2

; Parameters
;   Stack1 -- Sticks count
;   Stack2 -- Pointer to TMatchState
; Returns
;   AX -- TRUE if move is valid, FALSE otherwise
Game.Logic.Public.IsValidMove:
    push bp
    mov bp, sp
    push bx
    push cx

    mov ax, FALSE

    cmp word [bp + 4], Game.Logic.MIN_STICKS_COUNT_PER_MOVE
    jb .End

    cmp word [bp + 4], Game.Logic.MAX_STICKS_COUNT_PER_MOVE
    ja .End

    mov bx, [bp + 6]
    movzx cx, [bx + Game.TMatchState.bCurrentSticksCount]
    cmp [bp + 4], cx
    ja .End

    mov ax, TRUE

.End:
    pop cx
    pop bx
    pop bp
    ret 4

; Parameters
;   Stack1 -- Pointer to TMatchState
; Returns
;   AX -- TRUE if game is over, otherwise FALSE
Game.Logic.Public.IsGameOver:
    push bp
    mov bp, sp
    push bx

    mov ax, FALSE
    mov bx, [bp + 4]
    cmp byte [bx + Game.TMatchState.bCurrentSticksCount], Game.Logic.MIN_STICKS_COUNT_PER_MOVE
    jae .End
    mov ax, TRUE

.End:
    pop bx
    pop bp
    ret 2

; Parameters
;   Stack1 -- Pointer to TMatchState
; Returns
;   AX -- TRUE if player 1 wins, FALSE otherwise
Game.Logic.Public.GetWinner:
    push bp
    mov bp, sp
    push bx

    mov bx, [bp + 4]
    movzx ax, [bx + Game.TMatchState.bIsFirstPlayerTurn]

    pop bx
    pop bp
    ret 2
