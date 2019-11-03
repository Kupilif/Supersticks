include 'System\Display\Display.public.asm'
include 'Game\UI\View\Game.UI.View.private.asm'

Game.UI.View.Public.Initialize:
    call Display.Public.Initialize
    call Display.Public.Clear

    push Game.UI.View.GAME_SCREEN_STICKS_GAP
    push Game.UI.View.GAME_SCREEN_STICK_WIDTH
    push Game.UI.View.GAME_SCREEN_STICK_HEIGHT
    call Display.Public.ConfigureSticksSize
    ret

Game.UI.View.Public.Finalize:
    call Display.Public.Finalize
    ret

; Parameters
;   Stack1 -- Selected game mode
; Returns
;   None
Game.UI.View.Public.ShowGameModeSelectScreen:
    push bp
    mov bp, sp

    call Display.Public.Clear

    push Game.UI.View.GAME_MODE_SELECT_SCREEN_TITLE_COLOR
    push Game.UI.View.GAME_MODE_SELECT_SCREEN_TITLE_COLUMN
    push Game.UI.View.GAME_MODE_SELECT_SCREEN_TITLE_ROW
    push Game.UI.View.sTitle
    call Display.Public.PrintString

    push Game.UI.View.GAME_MODE_SELECT_SCREEN_MODE_1_COLOR
    push Game.UI.View.GAME_MODE_SELECT_SCREEN_MODE_1_COLUMN
    push Game.UI.View.GAME_MODE_SELECT_SCREEN_MODE_1_ROW
    push Game.UI.View.sGameMode1
    call Display.Public.PrintString

    push Game.UI.View.GAME_MODE_SELECT_SCREEN_MODE_2_COLOR
    push Game.UI.View.GAME_MODE_SELECT_SCREEN_MODE_2_COLUMN
    push Game.UI.View.GAME_MODE_SELECT_SCREEN_MODE_2_ROW
    push Game.UI.View.sGameMode2
    call Display.Public.PrintString

    push word [bp + 4]
    call Game.UI.View.Private.SetGameModeSelector

    pop bp
    ret 2

; Parameters
;   Stack1 -- Selected game mode
; Returns
;   None
Game.UI.View.Public.UpdateGameModeSelectScreen:
    push bp
    mov bp, sp

    push word [bp + 4]
    call Game.UI.View.Private.SetGameModeSelector

    pop bp
    ret 2

; Parameters
;   Stack1 -- Selected game complexity
; Returns
;   None
Game.UI.View.Public.ShowGameComplexitySelectScreen:
    push bp
    mov bp, sp

    call Display.Public.Clear

    push Game.UI.View.GAME_COMPLEXITY_SELECT_SCREEN_TITLE_COLOR
    push Game.UI.View.GAME_COMPLEXITY_SELECT_SCREEN_TITLE_COLUMN
    push Game.UI.View.GAME_COMPLEXITY_SELECT_SCREEN_TITLE_ROW
    push Game.UI.View.sTitle
    call Display.Public.PrintString

    push Game.UI.View.GAME_COMPLEXITY_SELECT_SCREEN_COMPLEXITY_1_COLOR
    push Game.UI.View.GAME_COMPLEXITY_SELECT_SCREEN_COMPLEXITY_1_COLUMN
    push Game.UI.View.GAME_COMPLEXITY_SELECT_SCREEN_COMPLEXITY_1_ROW
    push Game.UI.View.sGameComplexity1
    call Display.Public.PrintString

    push Game.UI.View.GAME_COMPLEXITY_SELECT_SCREEN_COMPLEXITY_2_COLOR
    push Game.UI.View.GAME_COMPLEXITY_SELECT_SCREEN_COMPLEXITY_2_COLUMN
    push Game.UI.View.GAME_COMPLEXITY_SELECT_SCREEN_COMPLEXITY_2_ROW
    push Game.UI.View.sGameComplexity2
    call Display.Public.PrintString

    push Game.UI.View.GAME_COMPLEXITY_SELECT_SCREEN_COMPLEXITY_3_COLOR
    push Game.UI.View.GAME_COMPLEXITY_SELECT_SCREEN_COMPLEXITY_3_COLUMN
    push Game.UI.View.GAME_COMPLEXITY_SELECT_SCREEN_COMPLEXITY_3_ROW
    push Game.UI.View.sGameComplexity3
    call Display.Public.PrintString

    push word [bp + 4]
    call Game.UI.View.Private.SetGameComplexitySelector

    pop bp
    ret 2

; Parameters
;   Stack1 -- Selected game complexity
; Returns
;   None
Game.UI.View.Public.UpdateGameComplexitySelectScreen:
    push bp
    mov bp, sp

    push word [bp + 4]
    call Game.UI.View.Private.SetGameComplexitySelector

    pop bp
    ret 2

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
