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

; Parameters
;   Stack1 -- Pointer to TMatchConfiguration
; Returns
;   AX -- TRUE if match configuration was written to specified TMatchConfiguration, otherwise FALSE
Game.Public.ConfigureMatch:
    push bp
    mov bp, sp
    push bx

    mov bx, [bp + 4]

.SelectGameMode:
    call Game.UI.Public.SelectGameMode
    cmp ax, Game.CANCEL_ACTION
    je .ConfigurationCanceled
    mov [bx + Game.TMatchConfiguration.Mode], al
    cmp ax, Game.MODE_2
    je .ConfigurationSucceeded

.SelectGameComplexity:
    call Game.UI.Public.SelectGameComplexity
    cmp ax, Game.CANCEL_ACTION
    je .SelectGameMode
    mov [bx + Game.TMatchConfiguration.Complexity], al

.ConfigurationSucceeded:
    mov ax, Game.TRUE
    jmp @F

.ConfigurationCanceled:
    mov ax, Game.FALSE

@@:
    pop bx
    pop bp
    ret 2

; Parameters
;   Stack1 -- Pointer to initialized TMatchConfiguration
Game.Public.StartMatch:
    push bp
    mov bp, sp
    push ax
    push bx

    mov bx, [bp + 4]
    call Display.Public.Clear
    push 0xF
    push 0
    push 0
    push 1
    xor ax, ax
    mov al, [bx + Game.TMatchConfiguration.Mode]
    push ax
    call Display.Public.PrintNumber
    push 0xF
    push 0
    push 1
    push 1
    xor ax, ax
    mov al, [bx + Game.TMatchConfiguration.Complexity]
    push ax
    call Display.Public.PrintNumber
    call Keyboard.Public.ReadKey

    pop bx
    pop ax
    pop bp
    ret 2
