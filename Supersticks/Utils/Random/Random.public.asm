include 'Utils\Random\Random.private.asm'

; Parameters
;   None
; Returns
;   None
Random.Public.Initialize:
    push cx
    push dx

    call Random.Private.GetSystemTime
    mov [Random.wPreviousNumber], dx

    pop dx
    pop cx
    ret

; Parameters
;   Stack1 -- Upper bound of generated number
; Returns
;   AX -- Generated number
Random.Public.Get:
    push bp
    mov bp, sp
    push dx

    mov ax, [Random.wPreviousNumber]
    rol ax, Random.MULTIPLICATION_COMPONENT
    add ax, Random.ADDITION_COMPONENT
    mov [Random.wPreviousNumber], ax

    xor dx, dx
    div word [bp + 4]
    mov ax, dx

    pop dx
    pop bp
    ret 2
