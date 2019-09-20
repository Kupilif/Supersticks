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

    mov ax, [bp + 4]
    mov [Display.wStickHeight], ax
    mov ax, [bp + 6]
    mov [Display.wStickWidth], ax
    mov ax, [bp + 8]
    mov [Display.wSticksGap], ax

    mov ax, Display.HEIGHT_PX
    sub ax, [Display.wStickHeight]
    shr ax, 1
    mov bx, Display.WIDTH_PX
    mul bx
    mov [Display.wFirstStickBasePosition], ax

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

    mov ax, [bp + 4]
    mov [Display.wSticksMaximumCount], ax

    mov bx, [Display.wStickWidth]
    add bx, [Display.wSticksGap]
    mul bx
    neg ax
    add ax, Display.WIDTH_PX
    add ax, [Display.wSticksGap]
    shr ax, 1
    mov [Display.wFirstStickOffsetFromBasePosition], ax
    add ax, [Display.wFirstStickBasePosition]
    mov [Display.wFirstStickOffsetPosition], ax

    pop bx
    pop ax
    pop bp
    ret 2

; Parameters
;   Stack1 -- Sticks count
;   Stack2 -- Sticks color
; Returns
;   None
; Remarks
;   Sticks size and position should be
;   configured before using this function
Display.Public.DrawSticks:
    push bp
    mov bp, sp
    push es
    push di
    push ax
    push bx
    push cx

    mov ax, Display.VIDEO_MEMORY_SEGMENT
    mov es, ax
    mov di, [Display.wFirstStickOffsetPosition]

    mov cx, [Display.wStickHeight]
    .Display.Public.DrawSticks.DrawRowsLoopStart:
        push cx

        mov ax, [bp + 6]
        xor cx, cx
        .Display.Public.DrawSticks.DrawStickInRowLoopStart:
            push cx

            mov cx, [Display.wStickWidth]
            cld
            rep stosb

            pop cx
            inc cx

            mov bx, cx
            xor bx, [bp + 4]
            jnz @F
            mov ax, Display.CLEAR_COLOR

        @@:
            mov bx, cx
            xor bx, [Display.wSticksMaximumCount]

            jz .Display.Public.DrawSticks.DrawStickInRowLoopEnd
            add di, [Display.wSticksGap]
            jmp .Display.Public.DrawSticks.DrawStickInRowLoopStart
        .Display.Public.DrawSticks.DrawStickInRowLoopEnd:

        add di, [Display.wFirstStickOffsetFromBasePosition]
        add di, [Display.wFirstStickOffsetFromBasePosition]

        pop cx
        loop .Display.Public.DrawSticks.DrawRowsLoopStart

    pop cx
    pop bx
    pop ax
    pop di
    pop es
    pop bp
    ret 4

include 'System\Display\Display.private.asm'
