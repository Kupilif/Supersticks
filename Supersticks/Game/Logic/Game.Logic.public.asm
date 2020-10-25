include 'Utils\Random\Random.public.asm'
include 'Game\Logic\Game.Logic.private.asm'

Game.Logic.Public.Initialize:
    call Random.Public.Initialize
    ret

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
    jne .End
    mov ax, TRUE

.End:
    pop bx
    pop bp
    ret 2
