require 'interaction'
require 'human'
require 'cpu'

class Game
    def initialize(difficulty, mode)
        @board =  ["0", "1", "2", "3", "4", "5", "6","7", "8"]
        @difficulty = difficulty
        @mode = mode
        @players = Hash.new()
        @p1turn = true
        @p1_symbol = "X"
        @p2_symbol = "O"
    end
    
    def start
        create_players
        until Game.game_is_over(@board) || tie(@board)
            Interaction.show_board(@board)
            #* Players move
            @players[@p1turn].move(@board)
            check_end_game
            advance_turn
        end
    end

    def create_players
        case MODES[@mode]
            when 'human VS computer'
                @players = { true => Human.new(@p1_symbol, @p2_symbol), false => Cpu.new(@p2_symbol, @p1_symbol, @difficulty) }
            when 'human VS human'
                @players = { true => Human.new(@p1_symbol, @p2_symbol), false => Human.new(@p2_symbol, @p1_symbol) }
            when 'computer VS computer'
                @players = { true => Cpu.new(@p1_symbol, @p2_symbol, @difficulty), false => Cpu.new(@p2_symbol, @p1_symbol, @difficulty) }
        end
    end

    def advance_turn
        @p1turn = !@p1turn
    end

    def Game.game_is_over(b)
        [b[0], b[1], b[2]].uniq.length == 1 ||
        [b[3], b[4], b[5]].uniq.length == 1 ||
        [b[6], b[7], b[8]].uniq.length == 1 ||
        [b[0], b[3], b[6]].uniq.length == 1 ||
        [b[1], b[4], b[7]].uniq.length == 1 ||
        [b[2], b[5], b[8]].uniq.length == 1 ||
        [b[0], b[4], b[8]].uniq.length == 1 ||
        [b[2], b[4], b[6]].uniq.length == 1
    end

    def tie(b)
        b.all? { |s| s == @p1_symbol || s == @p2_symbol }
    end

    def check_end_game
        if(Game.game_is_over(@board))
            Interaction.show_board(@board)
            Interaction.say("#{ @p1turn ? 'Player 1' : 'Player 2' } Wins!!!  With #{ @players[@p1turn].symbol } symbol")
        elsif(tie(@board))
            Interaction.say('Game over, it was a tie')
        end
    end
end