# frozen_string_literal: true

require_relative 'talk'

# instantiate a game. the user presses enter if they want to make the code, so
# if @maker = nil then maker = true
class Game
  include Talk
  attr_reader :over, :turn, :maker

  def initialize(maker, code)
    greet
    @over = false
    @turn = 12
    @maker = gets.chomp
    @code = code
  end

  def announce_turns
    puts "There are #{@turn} turns remaining."
  end

  def maker?
    true unless @maker
  end

  def take_turns(board)
    reminder
    until @over
      puts board
      announce_turns
      guess = last_four(gets.chomp.downcase)
      end_game(guess) if guess.chars == @code
      board.record_guess(guess, @turn, give_feedback(guess))
      @turn -= 1
      out_of_turns? ? end_game(guess) : next
    end
  end

  def correct?(guess)
    @code == guess.chars ? @over = true : false
  end

  def out_of_turns?
    @turn.zero?
  end

  private

  attr_reader :code
end

# provide feedback on guesses to breaker
class Feedback
  WORST = %w[x x x x].freeze
  attr_reader :feedback

  def initialize(code)
    @code = code
    @feedback = WORST
  end

  def last_four(guess)
    guess[-4..] || guess
  end

  def give_feedback(guess)
    guess = last_four(guess.chars)
    check_code(guess)
    @feedback
  end

  def check_code(guess)
    guess.each_with_index do |char, index|
    if @code.include?(char) && char != @code[index]
      @feedback[index] = 'o'
    elsif char == @code[index]
      @feedback[index] = 'c'
    else
      @feedback[index] = 'x'
    end
    end
  end

  private

  attr_writer :feedback
end

# represent the board
class Board < Feedback
  BLANK_ROW = '____ | xxxx'
  INITIAL_BOARD_STATE = Array.new(12) { String.new(BLANK_ROW) }

  attr_reader :board

  def initialize
    super
    @board = INITIAL_BOARD_STATE
  end

  def record_guess(guess, turn, feedback)
    @board[turn - 1] = "[Turn #{turn}]: #{guess} | #{feedback.join('')}"
  end

  def to_s
    readable = @board.join("\n")
    "---------Board---------\n#{readable}"
  end

  private

  attr_writer :board
end
