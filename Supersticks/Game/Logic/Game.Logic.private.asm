
; Parameters
;   Stack1 -- Current sticks count
; Returns
;   AX -- Sticks count which should be taken on current step to win the round.
;       0 when round could not be win from current state
Game.Logic.Private.HowMuchSticksTakeToWin:
    push bp
    mov bp, sp

    mov ax, [bp + 4]

    cmp ax, Game.Logic.MIN_STICKS_COUNT_PER_MOVE
    je .VictoryNotPossible

    mov bl, Game.Logic.MIN_STICKS_COUNT_PER_MOVE + Game.Logic.MAX_STICKS_COUNT_PER_MOVE
    div bl ; AL -- Quotient, AH -- Remainder

    test ah, ah
    jz .VictoryNotPossible

    test al, al
    jnz @F
    sub ah, Game.Logic.MIN_STICKS_COUNT_PER_MOVE
@@:
    movzx ax, ah
    jmp .End

.VictoryNotPossible:
    xor ax, ax

.End:
    pop bp
    ret 2