    org 100h

include 'Game\Game.h.asm'

Start:
    call Game.Public.Initialize
    call Game.Public.Finalize
    ret

include 'Game\Game.public.asm'
include 'Game\Game.di.asm'
include 'Game\Game.du.asm'
