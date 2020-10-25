include 'System\Keyboard\Keyboard.private.asm'

; Parameters
;   None
; Returns
;   AX -- Read key
Keyboard.Public.ReadKey:
    call Keyboard.Private.ClearInputBufferAndReadCharacter
    test al, al
    jnz @F
    call Keyboard.Private.ReadCharacter
@@:
    xor ah, ah
    ret
