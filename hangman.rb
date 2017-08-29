require 'json'
require_relative 'lib/game.rb'
require_relative 'lib/players.rb'
require_relative 'lib/dictionary.rb'
require_relative 'lib/big_brother.rb'
require_relative 'lib/saveload.rb'
require_relative 'lib/dict_graph.rb'

# Start screen of the game
class Hangman

  def play
    system 'clear'
    puts '*******************************************************'
    puts '**   Welcome to Hangman! Don\'t let them hang you!   **'
    puts '*******************************************************'
    puts ''
    puts 'What do you want?'
    puts ''
    puts '(1) Play new game'
    puts '(2) Watch AI play'
    puts '(3) Load saved game'
    puts '(4) Delete saved game'
    puts '(5) Exit'
    input = gets.chomp
    choice_controler(input)
  end

  def choice_controler(input)
    input = input.to_i
    return Game.new({player: Player.new.name}).play if input == 1
    return Game.new({}).play if input == 2
    return SaveLoad.new.load_delete_screen('load') if input == 3
    return SaveLoad.new.load_delete_screen('delete') if input == 4
    exit if input == 5
  end
end

Hangman.new.play
