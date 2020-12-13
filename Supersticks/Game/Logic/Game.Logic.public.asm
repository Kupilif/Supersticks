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
    mov word [Game.Logic.wComuterMakesCorrectMoveProbability], Game.Logic.COMPLEXITY_1_COMPUTER_MAKES_CORRECT_MOVE_PROBABILITY
    jmp .End

@@:
    cmp byte [bx + Game.TMatchConfiguration.bComplexity], Game.COMPLEXITY_2
    jne @F
    mov word [Game.Logic.wPlayer1StartsRoundProbability], Game.Logic.COMPLEXITY_2_PLAYER_1_STARTS_ROUND_PROBABILITY
    mov word [Game.Logic.wComuterMakesCorrectMoveProbability], Game.Logic.COMPLEXITY_2_COMPUTER_MAKES_CORRECT_MOVE_PROBABILITY
    jmp .End

@@:
    mov word [Game.Logic.wPlayer1StartsRoundProbability], Game.Logic.COMPLEXITY_3_PLAYER_1_STARTS_ROUND_PROBABILITY
    mov word [Game.Logic.wComuterMakesCorrectMoveProbability], Game.Logic.COMPLEXITY_3_COMPUTER_MAKES_CORRECT_MOVE_PROBABILITY
    jmp .End

.UserVsUser:
    mov word [Game.Logic.wPlayer1StartsRoundProbability], Game.Logic.COMPLEXITY_NONE_PLAYER_1_START_ROUND_PROBABILITY
    mov word [Game.Logic.wComuterMakesCorrectMoveProbability], Game.Logic.COMPLEXITY_NONE_COMPUTER_MAKES_CORRECT_MOVE_PROBABILITY

.End:
    pop bx
    pop bp
    ret 2

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
    cmp byte [bx + Game.TMatchState.bCurrentSticksCount], 0
    jg .End
    mov ax, TRUE

.End:
    pop bx
    pop bp
    ret 2

; Parameters
;   None
; Returns
;   AX -- TRUE if player 1 starts round, FALSE otherwise
Game.Logic.DoesPlayer1StartRound:
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
Game.Logic.GetSticksCount:
    push Game.Logic.MAX_STICKS_COUNT - Game.Logic.MIN_STICKS_COUNT + 1
    call Random.Public.Get
    add ax, Game.Logic.MIN_STICKS_COUNT
    ret

; Parameters
;   None
; Returns
;   AX -- Sticks count
Game.Logic.GetComputerMove:
    mov ax, 1
    ret
