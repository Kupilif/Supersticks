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
Display.Private.SetVideoMode:
    mov ah, 0x00
    int 0x10
    ret

; Parameters
;   AL -- Video page number
; Returns
;   None
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
Display.Private.PrintCharacter:
    mov ah, 0x0E
    int 0x10
    ret
