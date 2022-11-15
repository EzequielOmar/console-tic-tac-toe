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
    end
end

app = App.new.start