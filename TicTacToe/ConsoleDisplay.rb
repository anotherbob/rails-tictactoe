require 'readline'

module TicTacToe
	class ConsoleDisplay
		def printScore(players, playerScores)
			puts "\n\nCurrent Score:"
			players.each do | player |
				puts "Player #{player} has won #{playerScores[player]} games."
			end
			puts "\n------------------------\n\nStarting next match\n"
		end

		def printFinalScore(players, playerScores)
			puts "\n\nFinal Score:"
			players.each do | player |
				puts "Player #{player} has won #{playerScores[player]} games."
			end
			puts "\n------------------------\n\nThank you for playing!\n"
		end

		def warning(warning)
			puts "warning: "+warning
		end

		def showBoard(board)
			idx = 0

			board.each { | row |
				print "\n-------------\n|"
				row.each { | cell |
					idx = idx + 1
					if (cell == '') then
						print " #{idx} |"
					else
						print " #{cell} |"
					end
				}
			}

			puts "\n-------------\n"
		end

		def drawWin(board, winner, cells)
			puts "\nPlayer #{winner} has won this match!"

			idx = 0
			iidx = 0
			board.each do | row |
				print "\n-------------\n|"
				row.each do | cell |
					if (cells.include?([idx, iidx]))
						print " #{cell} |"
					else
						print "   |"
					end
					iidx = iidx + 1
				end
				idx = idx + 1
				iidx = 0
			end
			puts "\n-------------"
		end

		def declareTie
			puts "\nNeither player won this match."
			puts "\nStarting next match."
		end

		def prompt(request)
			puts "#{request}\nOr type 'exit' to end the game."

			begin
				Readline.readline
			rescue
				puts "ERROR: No mechanism for accepting input."
				exit
			end
		end
	end
end