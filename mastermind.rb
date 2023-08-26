# frozen_string_literal: true

require_relative 'talk'

# transform user input to translate code
module CodeHelper
  def last_four(guess)
    guess[-4..] || guess
  end

  def take_input
    gets.chomp
  end
end

# provide feedback on guesses to breaker
class Feedback
  WORST = %w[x x x x].freeze
  include CodeHelper
  attr_reader :feedback

  def initialize(code)
    @code = last_four(code)
    @feedback = WORST
  end

  def check_code
    guess = last_four(take_input)
    guess.each_with_index do |char, index|
      char == @code[index] && @feedback[index] = 'c'
      @code.include?(char) && @feedback[index] = 'o' || @feedback[index] = 'x'
    end
  end

  def give_feedback(guess)
    check_code(guess)
    @feedback
  end

  private

  attr_writer :feedback
end

# represent the board
class Board
  BLANK_ROW = '____ | xxxx'
  INITIAL_BOARD_STATE = Array.new(12) { String.new(BLANK_ROW) }
  include CodeHelper
  attr_reader :board

  def initialize
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

# instantiate a game. the user presses enter if they want to make the code, so
# if @breaker = nil then maker = true
class Game
  COLORS = %w[r o y g b v].freeze
  include CodeHelper
  include Talk
  attr_reader :over, :turn, :breaker

  def initialize
    @over = false
    @turn = 12
    greet
    @breaker = take_input
    @breaker && @code = pick_random_colors || @code = take_input.chars
  end

  def pick_random_colors
    Array.new(4) { COLORS.sample }
  end

  def announce_turns
    puts "There are #{@turn} turns remaining."
  end

  def take_turns(board)
    reminder
    until game_over?
      puts board
      announce_turns
      guess = last_four(take_input.downcase)
      board.record_guess(guess, @turn, give_feedback(guess))
      @turn -= 1
      out_of_turns? ? end_game : next
    end
  end

  def correct?
    guess =
    @code == guess.chars
  end

  def out_of_turns?
    @turn.zero?
  end

  def game_over?
    @over
  end

  private

  attr_reader :code
  attr_writer :over

  def end_game
    @over = true
  end
end

game = Game.new
