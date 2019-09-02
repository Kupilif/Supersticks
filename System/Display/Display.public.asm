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

include 'System\Display\Display.private.asm'
