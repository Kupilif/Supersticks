; Parameters
;   None
; Returns
;   CH -- Hour (0 - 23)
;   CL -- Minutes (0 - 59)
;   DH -- seconds (0 - 59)
;   DL -- Hundredths of a second (0 - 99)
Random.Private.GetSystemTime:
    mov ah, 2Ch
    int 21h
    ret
