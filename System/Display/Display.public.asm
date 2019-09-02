Display.Public.Initialize:
    push ax
    push bx

    call Display.Private.GetCurrentVideoInfo
    mov [Display.bVideoMode], al
    mov [Display.bVideoPage], bh
    mov al, Display.VM_GRAPHIC_640_480_256
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

include 'System\Display\Display.private.asm'
