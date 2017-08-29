# Players to play
class Player
  attr_reader :name

  def initialize
    puts 'Please enter your name'
    p @name = gets.chomp
  end

  def guess
    gets.chomp
  end
end

# AI that plays hangman
class AI
  attr_reader :knowledge, :name
  attr_accessor :counter

  def initialize(word_size)
    @knowledge = DictionaryGraph.new.letter_occ_in_words(word_size)
    @name = 'AI'
    @counter = -1
  end

  def guess
    simulation
    @counter += 1
    knowledge[counter]
  end

  def simulation
    str = "\r#{name} is thinking"
    10.times do
      print str += '.'
      sleep(0.2)
    end
  end
end
