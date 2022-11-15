module Interaction
    def Interaction.show_welcome_message
        puts '              Welcome human!'
        puts '  Do you want to play some tic-tac-toe?'
        puts '*---------------------------------------*'
    end
        
    def Interaction.show_menu
        puts '|MENU| Enter:'
        puts "  [s] to start game"
        puts "  [d] to change difficulty (current: '#{ DIFFICULTYS[$current_dificulty] }')"
        puts "  [m] to change game mode (current: '#{ MODES[$current_mode] }')"
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

    def Interaction.ask_input(*valids)
        input = gets.chomp
        Interaction.clear_console
        if input.to_i > 0 and valids.include?(input.to_i)
            return input.to_i
        elsif valids.include?(input)
            return input
        else
            return nil
        end
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