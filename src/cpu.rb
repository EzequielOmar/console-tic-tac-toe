require 'interaction'
require 'player'

class Cpu < Player
    def initialize(symbol, difficulty)
        super(symbol)
        @difficulty = difficulty
    end

    def move(board)
        computer_spot = nil
        until computer_spot
            if board[4] == "4"
                computer_spot = 4
                board[computer_spot] = @symbol
            else
                computer_spot = get_best_move(board, next_player_symbol)
                if board[computer_spot] != @symbol && board[computer_spot] != @opponent_symbol
                    board[computer_spot] = @symbol
                else
                    computer_spot = nil
                end
            end
        end
    end

    def get_best_move(board, next_player_symbol)
        available_spaces = []
        best_move = nil
        board.each do |s|
            if s != @symbol && s != @opponent_symbol
                available_spaces << s
            end
        end
        available_spaces.each do |as|
            board[as.to_i] = @symbol
            if Game.game_is_over(board)
                best_move = as.to_i
                board[as.to_i] = as
                return best_move
            else
                board[as.to_i] = next_player_symbol
                if Game.game_is_over(board)
                    best_move = as.to_i
                    board[as.to_i] = as
                    return best_move
                else
                    board[as.to_i] = as
                end
            end
        end
        if best_move
            return best_move
        else
            n = rand(0..available_spaces.count)
            return available_spaces[n].to_i
        end
    end
end