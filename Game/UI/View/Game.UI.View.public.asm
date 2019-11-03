include 'System\Display\Display.public.asm'
include 'Game\UI\View\Game.UI.View.private.asm'

Game.UI.View.Public.Initialize:
    call Display.Public.Initialize
    call Display.Public.Clear

    push Game.UI.View.STICKS_GAP
    push Game.UI.View.STICK_WIDTH
    push Game.UI.View.STICK_HEIGHT
    call Display.Public.ConfigureSticksSize
    ret

Game.UI.View.Public.Finalize:
    call Display.Public.Finalize
    ret

; Parameters
;   Stack1 -- Maximum sticks count
; Returns
;   None 
Game.UI.View.Public.ConfigureGameScreen:
    push bp
    mov bp, sp
    push ax

    mov ax, [bp + 4]
    push ax
    call Display.Public.ConfigureSticksPosition

    pop ax
    pop bp
    ret 2
