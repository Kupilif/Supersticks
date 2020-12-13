; Parameters
;   None
; Returns
;   CH -- Hour (0 - 23)
;   CL -- Minutes (0 - 59)
;   DH -- seconds (0 - 59)
;   DL -- Hundredths of a second (0 - 99)
Random.Private.GetSystemTime:
    push ax

    mov ah, 0x2C
    int 0x21

    pop ax
    ret
