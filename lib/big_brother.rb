# Big brother for the game
class BigBrother
  attr_reader :secret_word, :player, :id, :used_letters, :guessed_letters, :remaining_moves

  def initialize(args)
    @secret_word = args[:secret_word] || Dictionary.new.word
    @guessed_letters = args[:guessed_letters] || Array.new(secret_word.size) { '-' }
    @used_letters = args[:used_letters] || []
    @remaining_moves = args[:remaining_moves] || 10
    @player = args[:player] || AI.new(secret_word.size)
    @id = args[:id] || random_id
  end

  def guessed_so_far(letter)
    idx = (0...secret_word.length).find_all { |i| secret_word.join[i, 1] == letter }
    idx.each { |i| guessed_letters[i] = letter }
  end

  def good_guess(letter)
    used_letters << letter
    (secret_word.include?letter) ? guessed_so_far(letter) : @remaining_moves -= 1
    game_over?
  end

  def check_input(input)
    return check_if_used(input) if input.match(/[A-Za-z]/) && input.size == 1
    return SaveLoad.new.save_game(to_save) if input.to_i == 1
    return Hangman.new.play if input.to_i == 2
    exit if input.to_i == 3
    puts 'Please enter ONE letter only'
  end

  def check_if_used(letter)
    return letter unless used_letters.include? letter
    puts 'You already used that letter. Take another guess!'
    puts "Used letters: #{used_letters.join(', ')}"
  end

  def game_over?
    win_msg if win?
    lost_msg if lost?
  end

  def win?
    secret_word == guessed_letters
  end

  def lost?
    @remaining_moves.zero?
  end

  def win_msg
    puts 'You guessed it!!'
    puts "Secret word was: #{secret_word.join}"
    play_again?
  end

  def lost_msg
    puts ''
    puts 'Sorry, but, you\'ve been hanged!'
    puts "Secret word was: #{secret_word.join}"
    play_again?
  end

  def play_again?
    puts 'Do you want to play again? (1) YES, (2) NO'
    choice = gets.chomp
    exit if choice == '2'
    Game.new({ player: player }).play if choice == '1' && player.class == Player
    Game.new({player: AI.new(secret_word.size)}).play if choice == '1' && player.class == AI
  end

  def random_id
    (rand(26)+97).chr + (rand(899)+100).to_s + (rand(26)+65).chr
  end

  def to_save
    { id: id,
      player: player,
      secret_word: secret_word,
      guessed_letters: guessed_letters,
      used_letters: used_letters,
      remaining_moves: remaining_moves
    }
  end
end
