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
Game.TMatchConfiguration.Mode = 0
Game.TMatchConfiguration.Complexity = 1

Game.TMatchState.SIZE_BYTES = 11
Game.TMatchState.InitialSticksCount = 0
Game.TMatchState.CurrentSticksCount = 1
Game.TMatchState.IsFirstPlayerTurn = 2
Game.TMatchState.Player1Score = 3
Game.TMatchState.Player2Score = 5
Game.TMatchState.Player1Name = 7
Game.TMatchState.Player2Name = 9
