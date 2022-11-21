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
                computer_spot = get_move(board)
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

    def get_move(board)
        move = nil
        available_spaces = get_available_spaces(board)
        if DIFFICULTYS[@difficulty] == 'easy'
            move = just_pick_random(available_spaces)
        elsif DIFFICULTYS[@difficulty] == 'medium'
            #* Get the winner move, or opponent winners move
            available_spaces.each do |as|
                board[as.to_i] = @symbol
                if Game.game_is_over(board)
                    move = as.to_i
                    board[as.to_i] = as
                else
                    board[as.to_i] = @opponent_symbol
                    if Game.game_is_over(board)
                        move = as.to_i
                        board[as.to_i] = as
                    else
                        board[as.to_i] = as
                    end
                end
            end 
        elsif DIFFICULTYS[@difficulty] == 'hard'
            #* Get best possible move
            best_score = -1000
            available_spaces.each do |as|
                board[as.to_i] = @symbol
                move_score = nil
                move_score = evaluate_best_move(board, false, 0)
                board[as.to_i] = as
                if move_score > best_score
                    best_score = move_score
                    move = as.to_i
                end
            end
        end
        if move
            return move
        else
            return just_pick_random(available_spaces)
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

    def just_pick_random(available_spaces)
        n = rand(0..available_spaces.count)
        return available_spaces[n].to_i
    end

    def evaluate_best_move(board, playing_to_win, depth = 0)
        if player_wins(board, @symbol)
            return 10
        end
        if player_wins(board, @opponent_symbol)
            return -10
        end
        if Game.tie(board)
            return 0
        end
        available_spaces = get_available_spaces(board)
        if playing_to_win
            best = -1000
            available_spaces.each do |as|
                board[as.to_i] = @symbol
                current_score = evaluate_best_move(board, !playing_to_win, depth + 1)
                if current_score > best
                    best = current_score
                end
                board[as.to_i] = as
            end 
            return best
        else  
            best = 1000
            available_spaces.each do |as|
                board[as.to_i] = @opponent_symbol
                current_score = evaluate_best_move(board,!playing_to_win, depth + 1)
                if current_score < best
                    best = current_score
                end
                board[as.to_i] = as
            end
            return best
        end
    end

    def player_wins(b, symbol)
        ([b[0], b[1], b[2]].uniq.length == 1 && [b[0], b[1], b[2]].uniq[0] == symbol) ||
        ([b[3], b[4], b[5]].uniq.length == 1 && [b[3], b[4], b[5]].uniq[0] == symbol) ||
        ([b[6], b[7], b[8]].uniq.length == 1 && [b[6], b[7], b[8]].uniq[0] == symbol) ||
        ([b[0], b[3], b[6]].uniq.length == 1 && [b[0], b[3], b[6]].uniq[0] == symbol) ||
        ([b[1], b[4], b[7]].uniq.length == 1 && [b[1], b[4], b[7]].uniq[0] == symbol) ||
        ([b[2], b[5], b[8]].uniq.length == 1 && [b[2], b[5], b[8]].uniq[0] == symbol) ||
        ([b[0], b[4], b[8]].uniq.length == 1 && [b[0], b[4], b[8]].uniq[0] == symbol) ||
        ([b[2], b[4], b[6]].uniq.length == 1 && [b[2], b[4], b[6]].uniq[0] == symbol)
    end

    def spot_is_correct(board, computer_spot)
        return board[computer_spot] != @symbol && board[computer_spot] != @opponent_symbol
    end
end