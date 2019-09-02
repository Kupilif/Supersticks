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
