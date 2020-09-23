module TicTacToe
	class Game
		@display = nil

		@board = nil
		@players = nil
		@currentPlayer = nil
		@playerScores = nil

		def initialize(display)
			@display = display

			@board = resetBoard()
			@players = ['X', 'O']
			@currentPlayer = 1
			@playerScores = {'X' => 0, 'O' => 0}
		end
	
		def play
			while (1) do
				showBoard
				@currentPlayer = (@currentPlayer - 1).abs
	
				result = { 'valid' => false }
				while result['valid'] == false do
					result = requestCell
				end
	
				if (win = checkWinner)
					declareWin win
				elsif (boardFull)
					declareTie
				end
			end
		end

		private

		def declareWin(win)
			winner = win['player']
			@playerScores[winner] = @playerScores[winner] + 1
			drawWin(winner, win['cells'])
			printScore
			@board = resetBoard
		end

		def declareTie
			@display.declareTie
			printScore
			@board = resetBoard
		end

		def resetBoard
			[['', '', ''], ['', '', ''], ['', '', '']]
		end

		def drawWin(winner, cells)
			@display.drawWin(@board, winner, cells)
		end

		def showBoard
			@display.showBoard(@board)
		end

		def requestCell
			response = @display.prompt "Player #{@players[@currentPlayer]}, please choose a square: "
			if (response == 'exit') then
				printFinalScore
				exit
			end
			addResponse(@players[@currentPlayer], response)
		end

		def addResponse(player, response)
			response = response.to_i
	
			if (response < 1 || response > 9) then
				@display.warning "Please enter a valid square"
				return {'valid' => false}
			end
	
			row = 0
			cell = 0
			while (response > 3) do
				response -= 3
				row += 1
			end

			while (response > 1) do
				response -= 1
				cell += 1
			end
	
			if (@board[row][cell] != '') then
				@display.warning("Your choice has already been taken")
				return {'valid' => false}
			end
	
			@board[row][cell] = player
	
			{'valid' => true}
		end

		def boardFull
			@board.each do | row |
				row.each do | cell |
					if (cell == '')
						return false
					end
				end
			end

			true
		end

		def checkWinner
			key = 0
			@board.each do | row |
				key = key + 1

				if (test = checkMatch(row[0], row[1], row[2])) then
					return {'player' => test, 'cells' => [[key, 0], [key, 1], [key, 2]]}
				end
			end

			3.times do | idx |
				if (test = checkMatch(@board[0][idx], @board[1][idx], @board[2][idx])) then
					return {'player' => test, 'cells' => [[0, idx], [1, idx], [2, idx]]}
				end
			end
	
			if (test = checkMatch(@board[0][0], @board[1][1], @board[2][2])) then
				return {'player' => @board[2][2], 'cells' => [[0, 0], [1, 1], [2, 2]]}
			end
	
			if (test = checkMatch(@board[0][2], @board[1][1], @board[2][0])) then
				return {'player' => @board[2][0], 'cells' => [[0, 2], [1, 1], [2, 0]]}
			end
	
			false
		end

		def checkMatch(cell1, cell2, cell3)
			if (cell1 == cell2 && cell2 == cell3 && cell3 != '')
				return cell3
			end
			return false
		end
	
		def printScore
			@display.printScore(@players, @playerScores)
		end

		def printFinalScore
			@display.printFinalScore(@players, @playerScores)
		end
	end
end