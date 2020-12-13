; Parameters
;   None
; Returns
;   AL -- Read character
; Remarks
;   AH value is undefined after execution
Keyboard.Private.ClearInputBufferAndReadCharacter:
    mov ax, 0x0C08
    int 0x21
    ret

; Parameters
;   None
; Returns
;   AL -- Read character
; Remarks
;   If result equals zero then extended ASCII input acquired.
;   Should be called second time to retreive extended input.
;   AH value is undefined after execution
Keyboard.Private.ReadCharacter:
    mov ah, 0x08
    int 0x21
    ret
