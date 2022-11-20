$LOAD_PATH << 'src'

require 'interaction'
require 'game'

#* Constants
DIFFICULTYS = { 1 => 'easy', 2 => 'medium', 3 => 'hard' }
MODES = { 1 => 'human VS computer', 2 => 'human VS human', 3 => 'computer VS computer' }

class App
    #* App variables
    @@current_dificulty = 1;
    @@current_mode = 2;

    def start
        Interaction.show_welcome_message
        menu_selection = nil
        #* App loop
        until menu_selection == 'q'
            menu_selection = self.handleMenuLoop
            case menu_selection
                when 'd'
                    self.handleDifficultyMenu
                when 'm'
                    self.handleModeMenu
                when 's'
                    game = Game.new(@@current_dificulty, @@current_mode)
                    game.start
            end          
        end
        #* End App
        Interaction.say('Bye! See you soon!')
    end

    def handleMenuLoop
        menu_selection = nil
        #* Main menu loop
        until menu_selection
            Interaction.show_menu(@@current_dificulty, @@current_mode)
            menu_selection = Interaction.get_input(['d', 'm', 's', 'q'])
            if menu_selection
                return menu_selection
            else
                Interaction.say('Wrong input, please try again...')
            end
        end
    end

    def handleDifficultyMenu
        menu_selection = nil
        Interaction.show_difficulty_menu
        menu_selection = Interaction.get_input((1..3).to_a)
        if menu_selection
            @@current_dificulty = menu_selection
        end
    end

    def handleModeMenu
        menu_selection = nil
        Interaction.show_mode_menu
        menu_selection = Interaction.get_input((1..3).to_a)
        if menu_selection
            @@current_mode = menu_selection
        end
    end
end

app = App.new.start