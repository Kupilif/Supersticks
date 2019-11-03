include 'System\Display\Display.private.asm'

Display.Public.Initialize:
    push ax
    push bx

    call Display.Private.GetCurrentVideoInfo
    mov [Display.bVideoMode], al
    mov [Display.bVideoPage], bh
    mov al, Display.VIDEO_MODE_GRAPHIC_13
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

    mov ax, Display.VIDEO_MODE_GRAPHIC_13_MEMORY_SEGMENT
    mov es, ax
    xor di, di

    mov cx, Display.VIDEO_MODE_GRAPHIC_13_WIDTH_PIXELS * Display.VIDEO_MODE_GRAPHIC_13_HEIGHT_PIXELS
    mov al, Display.COLOR_CLEAR
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

    mov ax, Display.VIDEO_MODE_GRAPHIC_13_HEIGHT_PIXELS
    sub ax, [Display.wStickHeight]
    shr ax, 1
    mov bx, Display.VIDEO_MODE_GRAPHIC_13_WIDTH_PIXELS
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
    add ax, Display.VIDEO_MODE_GRAPHIC_13_WIDTH_PIXELS
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

    mov ax, Display.VIDEO_MODE_GRAPHIC_13_MEMORY_SEGMENT
    mov es, ax
    mov di, [Display.wFirstStickOffsetPosition]

    mov cx, [Display.wStickHeight]
    .DrawRowsLoopStart:
        push cx

        mov ax, [bp + 6]
        xor cx, cx
        .DrawStickInRowLoopStart:
            push cx

            mov cx, [Display.wStickWidth]
            cld
            rep stosb

            pop cx
            inc cx

            mov bx, cx
            xor bx, [bp + 4]
            jnz @F
            mov ax, Display.COLOR_CLEAR

        @@:
            mov bx, cx
            xor bx, [Display.wSticksMaximumCount]

            jz .DrawStickInRowLoopEnd
            add di, [Display.wSticksGap]
            jmp .DrawStickInRowLoopStart
        .DrawStickInRowLoopEnd:

        add di, [Display.wFirstStickOffsetFromBasePosition]
        add di, [Display.wFirstStickOffsetFromBasePosition]

        pop cx
        loop .DrawRowsLoopStart

    pop cx
    pop bx
    pop ax
    pop di
    pop es
    pop bp
    ret 4

; Parameters
;   Stack1 -- Character
;   Stack2 -- Row
;   Stack3 -- Column
;   Stack4 -- Color
; Returns
;   None
Display.Public.PrintCharacter:
    push bp
    mov bp, sp
    push ax
    push bx

    push word [bp + 8]
    push word [bp + 6]
    call Display.Private.SetCursorPosition

    mov al, [bp + 4]
    mov bl, [bp + 10]
    call Display.Private.PrintCharacter

    pop bx
    pop ax
    pop bp
    ret 8

; Parameters
;   Stack1 -- Address of null-terminated string
;   Stack2 -- Row
;   Stack3 -- Column
;   Stack4 -- Color
; Returns
;   None
Display.Public.PrintString:
    push bp
    mov bp, sp
    push ax
    push bx
    push si

    push word [bp + 8]
    push word [bp + 6]
    call Display.Private.SetCursorPosition

    cld
    mov si, [bp + 4]
    mov bl, [bp + 10]
    .PrintLoopStart:
        lodsb

        test al, al
        jz .PrintLoopEnd

        call Display.Private.PrintCharacter
        jmp .PrintLoopStart
    .PrintLoopEnd:

    pop si
    pop bx
    pop ax
    pop bp
    ret 8

; Parameters
;   Stack1 -- Signed number
;   Stack2 -- Minimal digits count (excluding minus symbol)
;   Stack3 -- Row
;   Stack4 -- Column
;   Stack5 -- Color
; Returns
;   None
; Remarks
;   If number requires less than specified minimal digits
;   count than leading zero symbols would be printed
Display.Public.PrintNumber:
    push bp
    mov bp, sp
    push ax
    push bx
    push cx
    push si

    push word [bp + 10]
    push word [bp + 8]
    call Display.Private.SetCursorPosition

    mov ax, [bp + 4]
    cmp ax, 0
    jge @F

    neg ax
    push ax
    mov al, Display.SYMBOL_MINUS
    mov bl, [bp + 12]
    call Display.Private.PrintCharacter
    pop ax

@@:
    call Display.Private.GetDigitsOfNumber

    mov cx, [bp + 6]
    sub cx, bx
    cmp cx, 0
    jle @F

    push bx
    mov bl, [bp + 12]
    mov al, Display.SYMBOL_ZERO
    .PrintLeadingZeroSymbolsLoopStart:
        call Display.Private.PrintCharacter
        loop .PrintLeadingZeroSymbolsLoopStart
    pop bx

@@:
    std
    mov cx, bx
    add si, bx
    sub si, 1
    mov bl, [bp + 12]
    .PrintNumberDigitsLoopStart:
        lodsb
        add al, Display.SYMBOL_ZERO
        call Display.Private.PrintCharacter
        loop .PrintNumberDigitsLoopStart

    pop si
    pop cx
    pop bx
    pop ax
    pop bp
    ret 10
