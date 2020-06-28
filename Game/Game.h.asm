include 'Game\Logic\Game.Logic.h.asm'
include 'Game\UI\Game.UI.h.asm'

Game.CANCEL_ACTION = 0

Game.MODE_1 = 1
Game.MODE_2 = 2

Game.COMPLEXITY_1 = 1
Game.COMPLEXITY_2 = 2
Game.COMPLEXITY_3 = 3

Game.GAME_EXIT_CONFIRMATION_OPTION_1 = 1
Game.GAME_EXIT_CONFIRMATION_OPTION_2 = 2

Game.MODE_COUNT = 2
Game.COMPLEXITY_COUNT = 3
Game.GAME_EXIT_CONFIRMATION_OPTION_COUNT = 2

Game.TMatchConfiguration.SIZE_BYTES = 2
Game.TMatchConfiguration.bMode = 0
Game.TMatchConfiguration.bComplexity = 1

Game.TMatchState.SIZE_BYTES = 11
Game.TMatchState.bInitialSticksCount = 0
Game.TMatchState.bCurrentSticksCount = 1
Game.TMatchState.bIsFirstPlayerTurn = 2
Game.TMatchState.wPlayer1Score = 3
Game.TMatchState.wPlayer2Score = 5
Game.TMatchState.pszPlayer1Name = 7
Game.TMatchState.pszPlayer2Name = 9
