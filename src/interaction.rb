module Interaction
    def Interaction.show_welcome_message
        puts '              Welcome human!'
        puts '  Do you want to play some tic-tac-toe?'
        puts '*---------------------------------------*'
    end
        
    def Interaction.show_menu
        puts 'Enter:'
        puts "  [s] to start game"
        puts "  [d] to change difficulty (current difficulty: '#{ DIFFICULTYS[$current_dificulty] }')"
        puts "  [m] to change game mode (current mode: '#{ MODES[$current_mode] }')"
        puts "  [q] to quit"
    end

    def Interaction.ask_input(*valids)
        input = gets.chomp
        if valids.include?(input)
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