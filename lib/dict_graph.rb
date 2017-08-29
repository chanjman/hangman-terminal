require 'json'
require_relative 'dictionary.rb'

# Knowledge about the dictionary
class DictionaryGraph
  attr_reader :dictionary

  def initialize
    @dictionary = Dictionary.new
  end

  # finds words in a dictionary by given size
  def find_words_by_size(word_size)
    dictionary.possible_words.find_all { |word| word.size == word_size }
  end

  # writes to json file
  def write_to_file(to_write)
    File.open('./letter_frequency.json', 'w').write(to_write.to_json)
  end

  # finds occurence of letters in words, sorted - letter => words occuring in
  def letter_occ_in_words(word_size)
    words = find_words_by_size(word_size)
    letters = ('a'..'z').each_with_object({}) { |letter, hash| hash[letter] = 0 }
    words.each do |word|
      letters.each { |letter, freq| letters[letter] += 1 if word.include? letter }
    end
    letters.sort_by { |_key, value| value }.reverse.to_h.keys
  end
end

dict = DictionaryGraph.new

=begin
# sorts the letter frequency by size
def letter_frequency(word_size)
  words = letter_frequency_unsorted(words_by_size(word_size))
  words.each do |size_key, size_value|
    words[size_key] = size_value.sort_by { |_key, value| value }.reverse.to_h
  end
       .to_h
end

# converts words to characters for easier counting
def words_to_characters(words)
  words.each { |key, value| words[key] = value.join.chars }
end

# finds the letter count and makes a hash - letter => count
def letter_frequency_unsorted(to_freq)
  words = words_to_characters(to_freq)
  words.each do |key, value|
    words[key] = value.each_with_object(Hash.new(0)) do |chr, hash|
      hash[chr] += 1
      hash
    end
  end
end
=end
