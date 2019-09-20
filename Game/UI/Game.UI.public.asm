include 'System\Display\Display.public.asm'
include 'System\Keyboard\Keyboard.public.asm'
include 'Game\UI\Game.UI.private.asm'

Game.UI.Public.Initialize:
    call Display.Public.Initialize
    call Display.Public.Clear

    push Game.UI.STICKS_GAP
    push Game.UI.STICK_WIDTH
    push Game.UI.STICK_HEIGHT
    call Display.Public.ConfigureSticksSize
    ret

Game.UI.Public.Finalize:
    call Display.Public.Finalize
    ret

; Parameters
;   Stack1 -- Maximum sticks count
; Returns
;   None 
Game.UI.Public.ConfigureGameScreen:
    push bp
    mov bp, sp
    push ax

    mov ax, [bp + 4]
    push ax
    call Display.Public.ConfigureSticksPosition

    pop ax
    pop bp
    ret 2
