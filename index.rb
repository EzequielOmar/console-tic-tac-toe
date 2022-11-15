$LOAD_PATH << 'src'

require 'interaction'

# Constants
DIFFICULTYS = { 1 => 'easy', 2 => 'medium', 3 => 'hard' }
MODES = { 1 => 'human VS computer', 2 => 'human VS human', 3 => 'computer VS computer' }

class App
    $current_dificulty = 1;
    $current_mode = 1;

    def start
        Interaction.show_welcome_message
        menu_selection = nil
        # App loop
        until menu_selection == 'q'
            menu_selection = self.handleMenuLoop
            case menu_selection
                when 'd'
                    #TODO display change dificulty menu            
                when 'm'
                    #TODO display change mode menu      
                when 's'
                    #TODO start game  
            end          
        end
        Interaction.say('Bye! See you soon!')
    end

    def handleMenuLoop
        menu_selection = nil
        # Main menu loop
        until menu_selection
            Interaction.show_menu
            menu_selection = Interaction.ask_input('d', 'm', 's', 'q')
            if menu_selection
                return menu_selection
            else
                Interaction.clear_console
                Interaction.say('Wrong input, please try again...')
            end
        end
    end
end

app = App.new.start