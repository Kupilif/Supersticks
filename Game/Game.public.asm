Game.Public.Initialize:
    call Game.UI.Public.Initialize
    ret

Game.Public.Finalize:
    call Game.UI.Public.Finalize
    ret

include 'Game\Game.private.asm'

include 'Game\Logic\Game.Logic.public.asm'
include 'Game\UI\Game.UI.public.asm'
