; Parameters
;   None
; Returns
;   AL -- Current video mode
;   AH -- Width of screen, in character columns
;   BH -- Current active video page
Display.Private.GetCurrentVideoInfo:
    mov ah, 0x0F
    int 0x10
    ret

; Parameters
;   AL -- Video mode number
; Returns
;   None
; Remarks
;   AH value is undefined after execution
Display.Private.SetVideoMode:
    mov ah, 0x00
    int 0x10
    ret

; Parameters
;   AL -- Video page number
; Returns
;   None
; Remarks
;   AH value is undefined after execution
Display.Private.SetActiveVideoPage:
    mov ah, 0x05
    int 0x10
    ret

; Parameters
;   Stack1 -- Row
;   Stack2 -- Column
; Returns
;   None
Display.Private.SetCursorPosition:
    push bp
    mov bp, sp
    push ax
    push bx
    push dx

    mov ah, 0x02
    xor bh, bh
    mov dh, [bp + 4]
    mov dl, [bp + 6]
    int 0x10

    pop dx
    pop bx
    pop ax
    pop bp
    ret 4

; Parameters
;   AL -- Character
;   BL -- Color
; Returns
;   None
; Remarks
;   AH value is undefined after execution
Display.Private.PrintCharacter:
    mov ah, 0x0E
    int 0x10
    ret

; Parameters
;   AX -- Unsigned number which should be divided into digits
; Returns
;   BX -- Digits count
;   SI -- Start address of byte array with digits.
;       First byte contains last digit
; Remarks
;   Each call uses the same memory area for storing digits
Display.Private.GetDigitsOfNumber:
    push ax
    push cx
    push dx

    mov cx, 10
    mov bx, Display.abNumberDigits
    .DivisionLoopStart:
        xor dx, dx
        div word cx
        mov [bx], dl

        inc bx
        test ax, ax
        jnz .DivisionLoopStart

    sub bx, Display.abNumberDigits
    mov si, Display.abNumberDigits

    pop dx
    pop cx
    pop ax
    ret
