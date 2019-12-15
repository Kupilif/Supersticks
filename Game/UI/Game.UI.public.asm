include 'Game\UI\View\Game.UI.View.public.asm'
include 'Game\UI\Controller\Game.UI.Controller.public.asm'
include 'Game\UI\Game.UI.private.asm'

Game.UI.Public.Initialize:
    call Game.UI.View.Public.Initialize
    ret

Game.UI.Public.Finalize:
    call Game.UI.View.Public.Finalize
    ret

; Parameter
;   None
; Returns
;   AX -- Selected game mode
Game.UI.Public.SelectGameMode:
    push Game.UI.View.Public.UpdateGameModeSelectScreen
    push Game.UI.View.Public.ShowGameModeSelectScreen
    push Game.MODE_COUNT
    push Game.UI.abGameModeSelectOptions
    call Game.UI.Private.SelectFromList
    ret

; Parameter
;   None
; Returns
;   AX -- Selected game mode
Game.UI.Public.SelectGameComplexity:
    push Game.UI.View.Public.UpdateGameComplexitySelectScreen
    push Game.UI.View.Public.ShowGameComplexitySelectScreen
    push Game.COMPLEXITY_COUNT
    push Game.UI.abGameComplexitySelectOptions
    call Game.UI.Private.SelectFromList
    ret
