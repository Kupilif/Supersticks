include 'Game\UI\View\Game.UI.View.public.asm'
include 'Game\UI\Controller\Game.UI.Controller.public.asm'
include 'Game\UI\Game.UI.private.asm'

Game.UI.Public.Initialize:
    call Game.UI.View.Public.Initialize
    ret

Game.UI.Public.Finalize:
    call Game.UI.View.Public.Finalize
    ret
