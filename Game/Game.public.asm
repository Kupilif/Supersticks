include 'Game\Logic\Game.Logic.public.asm'
include 'Game\UI\Game.UI.public.asm'
include 'Game\Game.private.asm'

Game.Public.Initialize:
    call Game.UI.Public.Initialize
    call Game.Logic.Public.Initialize
    ret

Game.Public.Finalize:
    call Game.UI.Public.Finalize
    ret
