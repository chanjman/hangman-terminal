# Supplies the game with the dictionary
class Dictionary
  attr_reader :word

  def initialize
    @word = select_random_secret_word
  end

  DICTIONARY = './dictionary.txt'.freeze
  WORDLENGTH = 1, 12

  def dictionary
    dictionary = []
    File.open(DICTIONARY, 'r').each do |word|
      dictionary << word.downcase.chomp
    end
    dictionary
  end

  def possible_words
    dictionary.select do |word|
      word.length.between?(WORDLENGTH[0], WORDLENGTH[1])
    end
  end

  def select_random_secret_word
    possible_words[rand(possible_words.length)].split('')
  end
end
