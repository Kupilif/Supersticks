include 'System\Keyboard\Keyboard.private.asm'

; Parameters
;   None
; Returns
;   AX -- Read key
Keyboard.Public.ReadKey:
    push dx

    xor dx, dx
    call Keyboard.Private.ClearInputBufferAndReadCharacter
    mov dl, al

    test al, al
    jnz @F

    call Keyboard.Private.ReadCharacter
    mov dh, al

@@:
    mov ax, dx

    pop dx
    ret
