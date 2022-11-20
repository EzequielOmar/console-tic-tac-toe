module Interaction
    def Interaction.show_welcome_message
        puts '              Welcome human!'
        puts '  Do you want to play some tic-tac-toe?'
        puts '*---------------------------------------*'
    end
        
    def Interaction.show_menu(curr_dif, curr_mode)
        puts '|MENU| Enter:'
        puts "  [s] to start game"
        puts "  [d] to change difficulty (current: '#{ DIFFICULTYS[curr_dif] }')"
        puts "  [m] to change game mode (current: '#{ MODES[curr_mode] }')"
        puts "  [q] to quit"
    end

    def Interaction.show_difficulty_menu
        puts '|change difficulty| Enter:'
        puts "  [1] -> easy"
        puts "  [2] -> medium"
        puts "  [3] -> expert"
        puts "  [any] to cancel"
    end

    def Interaction.show_mode_menu
        puts '|change game mode| Enter:'
        puts "  [1] -> human VS computer"
        puts "  [2] -> human VS human"
        puts "  [3] -> computer VS computer"
        puts "  [any] to cancel"
    end

    def Interaction.show_board(board)
        puts " #{board[0]} | #{board[1]} | #{board[2]} \n———.———.———\n #{board[3]} | #{board[4]} | #{board[5]} \n———.———.———\n #{board[6]} | #{board[7]} | #{board[8]} \n"
    end

    def Interaction.get_input(valids = [])
        if !valids
            return nil
        end
        input = gets.chomp
        #* Clear console -always- right after user input
        Interaction.clear_console
        if input.match?(/\A\d+\Z/) && valids.include?(input.to_i)
            return input.to_i
        elsif valids.include?(input)
            return input
        end
        return nil
    end

    def Interaction.clear_console
        if RUBY_PLATFORM =~ /win32|win64|\.NET|windows|cygwin|mingw32/i
            system('cls')
        else
            system('clear')
        end
    end

    def Interaction.say(message)
        puts message
    end
end