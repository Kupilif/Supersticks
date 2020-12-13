; Parameters
;   Stack1 -- Current sticks count
; Returns
;   AX -- Sticks count which should be taken on current step to win the round.
;       0 when round could not be win from current state
Game.Logic.Private.HowMuchSticksTakeToWin:
    push bp
    mov bp, sp
    push bx

    mov ax, [bp + 4]
    mov bl, Game.Logic.MIN_STICKS_COUNT_PER_MOVE + Game.Logic.MAX_STICKS_COUNT_PER_MOVE
    div bl ; AL -- Quotient, AH -- Remainder

    cmp ah, Game.Logic.MIN_STICKS_COUNT_PER_MOVE
    jge @F

    mov ax, Game.Logic.MAX_STICKS_COUNT_PER_MOVE
    jmp .End
@@:
    sub ah, Game.Logic.MIN_STICKS_COUNT_PER_MOVE

    cmp ah, Game.Logic.MIN_STICKS_COUNT_PER_MOVE
    jge @F

    xor ax, ax
    jmp .End
@@:
    movzx ax, ah

.End:
    pop bx
    pop bp
    ret 2