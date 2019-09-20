include 'Utils\Random\Random.public.asm'
include 'Game\Logic\Game.Logic.private.asm'

Game.Logic.Public.Initialize:
    call Random.Public.Initialize
    ret
