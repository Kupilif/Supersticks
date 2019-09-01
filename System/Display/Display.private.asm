; Parameters
;   None
; Returns
;   AL -- Current video mode
;   AH -- Width of screen, in character columns
;   BH -- Current active video page
Display.Private.GetCurrentVideoInfo:
    mov ah, 0Fh
    int 10h
    ret

; Parameters
;   AL -- Video mode number
; Returns
;   None
Display.Private.SetVideoMode:
    mov ah, 00h
    int 10h
    ret

; Parameters
;   AL -- Video page number
; Returns
;   None
Display.Private.SetActiveVideoPage:
    mov ah, 05h
    int 10h
    ret
