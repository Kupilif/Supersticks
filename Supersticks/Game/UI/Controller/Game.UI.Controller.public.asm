include 'System\Keyboard\Keyboard.public.asm'
include 'Game\UI\Controller\Game.UI.Controller.private.asm'

; Parameters
;   None
; Returns
;   AX -- User action
Game.UI.Controller.Public.GetUserInputForSelectionFromList:
    .InputLoopStart:
        call Keyboard.Public.ReadKey

        cmp ax, Keyboard.VK_RETURN
        jne @F
        mov ax, Game.UI.Controller.SUBMIT
        jmp .InputLoopEnd

    @@:
        cmp ax, Keyboard.VK_ESCAPE
        jne @F
        mov ax, Game.UI.Controller.CANCEL
        jmp .InputLoopEnd

    @@:
        cmp ax, Keyboard.VK_UP
        jne @F
        mov ax, Game.UI.Controller.SELECT_PREVIOUS
        jmp .InputLoopEnd

    @@:
        cmp ax, Keyboard.VK_DOWN
        jne .InputLoopStart
        mov ax, Game.UI.Controller.SELECT_NEXT
    .InputLoopEnd:

    ret

; Parameters
;   None
; Returns
;   AX -- User move, FALSE if ESC was pressed
Game.UI.Controller.Public.GetUserMove:
    .InputLoopStart:
        call Keyboard.Public.ReadKey

        cmp ax, Keyboard.VK_ESCAPE
        jne @F
        mov ax, FALSE
        jmp .InputLoopEnd

    @@:
        cmp ax, Keyboard.0
        jb .InputLoopStart
        cmp ax, Keyboard.9
        ja .InputLoopStart

        sub ax, Keyboard.0

    .InputLoopEnd:

    ret

; Parameters
;   None
; Returns
;   AX -- FALSE if ESC was pressed, TRUE otherwise
Game.UI.Controller.Public.WaitForAnyKey:
    call Keyboard.Public.ReadKey

    cmp ax, Keyboard.VK_ESCAPE
    je @F

    mov ax, TRUE
    jmp .End

@@:
    mov ax, FALSE

.End:
    ret
