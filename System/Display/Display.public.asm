Display.Public.Initialize:
    call Display.Private.GetCurrentVideoInfo
    mov [Display.bVideoMode], al
    mov [Display.bVideoPage], bh
    mov al, Display.VM_GRAPHIC_640_480_256
    call Display.Private.SetVideoMode
    ret

Display.Public.Finalize:
    mov al, [Display.bVideoMode]
    call Display.Private.SetVideoMode
    mov al, [Display.bVideoPage]
    call Display.Private.SetActiveVideoPage
    ret

include 'System\Display\Display.private.asm'
