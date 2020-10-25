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
