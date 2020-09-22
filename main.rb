	require './TicTacToe/Game.rb'
	require './TicTacToe/ConsoleDisplay.rb'

	gameDisplay = TicTacToe::ConsoleDisplay.new
	game = TicTacToe::Game.new(gameDisplay)
	game.play