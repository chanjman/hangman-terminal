# Keep track of the game
require 'json'
# Plays the game
class Game
  attr_reader :brother

  def initialize(args)
    @brother = BigBrother.new(args)
  end

  def get_input(input = nil)
    loop do
      break if (input.to_s.match(/[a-z]/) && input.size == 1) || input.to_i == 1
      puts "#{brother.player}, take a guess | Save game (1) | Start screen (2) | Exit (3)"
      if brother.player.class == Player || brother.player.class == String
        input = brother.check_input(gets.chomp)
      else
        input = brother.check_input(brother.player.guess)
      end
    end
    input
  end

  def play
    loop do
      system 'clear'
      puts ''
      puts brother.guessed_letters.join(' ')
      puts ''
      puts "Leters used: #{brother.used_letters.join(', ')}" unless brother.used_letters.empty?
      puts "Remaining moves: #{brother.remaining_moves}"
      puts ''
      brother.good_guess(get_input)
    end
  end
end
