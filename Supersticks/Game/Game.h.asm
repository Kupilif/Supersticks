include 'Game\Logic\Game.Logic.h.asm'
include 'Game\UI\Game.UI.h.asm'

Game.MODE_1 = 1
Game.MODE_2 = 2
Game.MODE_COUNT = 2

Game.COMPLEXITY_1 = 1
Game.COMPLEXITY_2 = 2
Game.COMPLEXITY_3 = 3
Game.COMPLEXITY_COUNT = 3

Game.TMatchConfiguration.SIZE_BYTES = 2
Game.TMatchConfiguration.bMode = 0
Game.TMatchConfiguration.bComplexity = 1

Game.TMatchState.SIZE_BYTES = 12
Game.TMatchState.bInitialSticksCount = 0
Game.TMatchState.bCurrentSticksCount = 1
Game.TMatchState.bIsFirstPlayerTurn = 2
Game.TMatchState.bIsFirstPlayerWin = 3
Game.TMatchState.wPlayer1Score = 4
Game.TMatchState.wPlayer2Score = 6
Game.TMatchState.pszPlayer1Name = 8
Game.TMatchState.pszPlayer2Name = 10
