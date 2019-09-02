; Parameters
;   None
; Returns
;   AL -- Read character
Keyboard.Private.ClearInputBufferAndReadCharacter:
    mov ax, 0C08h
    int 21h
    ret

; Parameters
;   None
; Returns
;   AL -- Read character
; Remarks
;   If result equals zero then extended ASCII input acquired.
;   Should be called second time to retreive extended input
Keyboard.Private.ReadCharacter:
    mov ah, 0C08h
    int 21h
    ret
