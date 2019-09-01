Game.UI.Public.Initialize:
    call Display.Public.Initialize
    ret

Game.UI.Public.Finalize:
    call Display.Public.Finalize
    ret

include 'Game\UI\Game.UI.private.asm'

include 'System\Display\Display.public.asm'
include 'System\Keyboard\Keyboard.public.asm'
