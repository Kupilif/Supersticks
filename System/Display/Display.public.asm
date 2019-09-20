Display.Public.Initialize:
    push ax
    push bx

    call Display.Private.GetCurrentVideoInfo
    mov [Display.bVideoMode], al
    mov [Display.bVideoPage], bh
    mov al, Display.VM_GRAPHIC_320_200_256
    call Display.Private.SetVideoMode

    pop bx
    pop ax
    ret

Display.Public.Finalize:
    push ax

    mov al, [Display.bVideoMode]
    call Display.Private.SetVideoMode
    mov al, [Display.bVideoPage]
    call Display.Private.SetActiveVideoPage

    pop ax
    ret

Display.Public.Clear:
    push es
    push di
    push ax
    push cx

    mov ax, Display.VIDEO_MEMORY_SEGMENT
    mov es, ax
    xor di, di

    mov cx, Display.WIDTH_PX * Display.HEIGHT_PX
    mov al, Display.CLEAR_COLOR
    cld
    rep stosb

    pop cx
    pop ax
    pop di
    pop es
    ret

; Parameters
;   Stack1 -- Stick height
;   Stack2 -- Stick width
;   Stack3 -- Sticks gap
; Returns
;   None
Display.Public.ConfigureSticksSize:
    push bp
    mov bp, sp
    push ax
    push bx
    push dx

    mov ax, [bp + 4]
    mov [Display.wStickHeight], ax
    mov ax, [bp + 6]
    mov [Display.wStickWidth], ax
    mov ax, [bp + 8]
    mov [Display.wSticksGap], ax

    mov ax, Display.HEIGHT_PX
    sub ax, [Display.wStickHeight]
    xor dx, dx
    mov bx, 2
    div bx
    mov bx, Display.WIDTH_PX
    mul bx
    mov [Display.wFirstStickBasePosition], ax

    pop dx
    pop bx
    pop ax
    pop bp
    ret 6

; Parameters
;   Stack1 -- Maximum sticks count
; Returns
;   None
Display.Public.ConfigureSticksPosition:
    push bp
    mov bp, sp
    push ax
    push bx
    push dx

    mov ax, [bp + 4]
    mov [Display.wSticksMaximumCount], ax

    mov bx, [Display.wStickWidth]
    add bx, [Display.wSticksGap]
    mul bx
    neg ax
    add ax, Display.WIDTH_PX
    xor dx, dx
    mov bx, 2
    div bx
    mov [Display.wFirstStickOffsetFromBasePosition], ax
    add ax, [Display.wFirstStickBasePosition]
    mov [Display.wFirstStickOffsetPosition], ax

    pop dx
    pop bx
    pop ax
    pop bp
    ret 2

include 'System\Display\Display.private.asm'
