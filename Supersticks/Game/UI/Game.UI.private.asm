; Parameters
;   Stack1 -- Pointer to array with select options
;   Stack2 -- Select options count
;   Stack3 -- Pointer to function which shows selection screen with specified option selected
;   Stack4 -- Pointer to function which updates selection screen with specified option selected
; Returns
;   AX -- Selected option or FALSE if ESC was pressed
; Remarks
;   Each select option should be represented as byte
Game.UI.Private.SelectFromList:
    push bp
    mov bp, sp
    push bx
    push cx
    push dx

    xor cx, cx
    mov dx, [bp + 6]
    sub dx, 1

    mov bx, [bp + 4]
    add bx, cx
    xor ax, ax
    mov al, [bx]
    push ax
    call word [bp + 8]

    .SelectLoopStart:
        call Game.UI.Controller.Public.GetUserInputForSelectionFromList

        cmp ax, Game.UI.Controller.SUBMIT
        jne @F
        xor ax, ax
        mov al, [bx]
        jmp .SelectLoopEnd

    @@:
        cmp ax, Game.UI.Controller.CANCEL
        jne @F
        mov ax, FALSE
        jmp .SelectLoopEnd

    @@:
        cmp ax, Game.UI.Controller.SELECT_PREVIOUS
        jne @F
        call Game.UI.Private.CircularDecrementByOne
        jmp .UpdateScreen

    @@:
        cmp ax, Game.UI.Controller.SELECT_NEXT
        jne .SelectLoopStart
        call Game.UI.Private.CircularIncrementByOne

    .UpdateScreen:
        mov bx, [bp + 4]
        add bx, cx
        xor ax, ax
        mov al, [bx]
        push ax
        call word [bp + 10]

        jmp .SelectLoopStart
    .SelectLoopEnd:

    pop dx
    pop cx
    pop bx
    pop bp
    ret 8

; Parameters
;   Stack1 -- Pointer to TMatchState
;   Stack2 -- Pointer to TMatchConfiguration
;   Stack3 -- Pointer to function which reads user input
; Returns
;   AX -- User action, FALSE if match was cancelled
Game.UI.Private.GetGameActionFromUser:
    push bp
    mov bp, sp

    .InputLoopStart:
        call word [bp + 8]

        cmp ax, FALSE
        jne .InputLoopEnd

        call Game.UI.Public.ShouldContinueGame

        cmp ax, FALSE
        je .InputLoopEnd

    .ContinueGame:
        push word [bp + 6]
        push word [bp + 4]
        call Game.UI.Public.ShowMatch
        jmp .InputLoopStart

    .InputLoopEnd:

    pop bp
    ret 6

; Parameters
;   CX -- Current value
;   DX -- Maximum value
; Returns
;   CX -- Incremented value
; Remarks
;   Circle starts at zero and ends at specified maximum value
Game.UI.Private.CircularIncrementByOne:
    cmp cx, dx
    jb .LessThanMaximum
    xor cx, cx
    jmp @F
.LessThanMaximum:
    inc cx
@@:
    ret

; Parameters
;   CX -- Current value
;   DX -- Maximum value
; Returns
;   CX -- Decremented value
; Remarks
;   Circle starts at zero and ends at specified maximum value
Game.UI.Private.CircularDecrementByOne:
    test cx, cx
    jnz .NotZero
    mov cx, dx
    jmp @F
.NotZero:
    dec cx
@@:
    ret
