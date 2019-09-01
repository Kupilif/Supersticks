Random.Public.Initialize:
    call Random.Private.GetSystemTime
    mov [Random.wPreviousNumber], dx
    ret

; Parameters
;   Stack1 -- Upper bound of generated number
; Returns
;   DX -- Generated number
Random.Public.Get:
    push bp
    mov bp, sp

    mov ax, [Random.wPreviousNumber]
    rol ax, Random.MULTIPLICATION_COMPONENT
    add ax, Random.ADDITION_COMPONENT
    mov [Random.wPreviousNumber], ax

    xor dx, dx
    div word [bp + 4]

    pop bp
    ret 2

include 'Utils\Random\Random.private.asm'
