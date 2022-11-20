require 'interaction'
require 'player'

class Human < Player 
    def move(board)
        human_spot = nil
        until human_spot
            Interaction.show_board(board)
            Interaction.say("Player #{ @symbol }'s turn. Enter [0-8]:")
            human_spot = Interaction.get_input((0..8).to_a)
            if spot_is_correct(board, human_spot)
                board[human_spot] = @symbol
            else
                human_spot = nil
                Interaction.say('Wrong input, please try again...')
            end
        end
    end

    def spot_is_correct(board, human_spot)
        return human_spot && board[human_spot] != @symbol && board[human_spot] != @opponent_symbol
    end
end