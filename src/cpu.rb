require 'interaction'
require 'player'

class Cpu < Player
    def initialize(symbol, opponent_symbol, difficulty)
        super(symbol, opponent_symbol)
        @difficulty = difficulty
    end

    def move(board)
        computer_spot = nil
        until computer_spot
            computer_spot = check_for_middle(board)
            if !computer_spot
                computer_spot = get_best_move(board)
                if spot_is_correct(board, computer_spot) 
                    board[computer_spot] = @symbol
                else
                    computer_spot = nil
                end
            end
        end
    end

    def check_for_middle(board)
        if board[4] == "4"
            board[4] = @symbol
            return 4
        else
            return nil
        end
    end

    def get_best_move(board)
        best_move = nil
        available_spaces = get_available_spaces(board)
        available_spaces.each do |as|
            if @difficulty > 2
                best_move = check_opponent_winner_move(board, as)
            end
            if @difficulty > 1
                best_move = check_winner_move(board, as)
            end
            if !best_move 
                board[as.to_i] = as
            end
        end
        if best_move
            return best_move
        else
            n = rand(0..available_spaces.count)
            return available_spaces[n].to_i
        end
    end

    def get_available_spaces(board)
        available_spaces = []
        board.each do |s|
            if s != @symbol && s != @opponent_symbol
                available_spaces << s
            end
        end
        return available_spaces
    end

    def check_winner_move(board, as)
        board[as.to_i] = @symbol
        if Game.game_is_over(board)
            best_move = as.to_i
            return best_move
        end
        return nil
    end
    
    def check_opponent_winner_move(board, as)
        board[as.to_i] = @opponent_symbol
        if Game.game_is_over(board)
            best_move = as.to_i
            return best_move
        end
        return nil
    end

    def spot_is_correct(board, computer_spot)
        return board[computer_spot] != @symbol && board[computer_spot] != @opponent_symbol
    end
end