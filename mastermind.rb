# frozen_string_literal: true

require_relative 'talk'

# transform user input to translate code
module CodeHelper
  def last_four(input)
    input[-4..] || input
  end

  def take_input
    last_four(gets.chomp.downcase.chars)
  end
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

  def record_guess(turn, guess, feedback)
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
  ALL_WRONG = %w[x x x x].freeze
  include CodeHelper
  include Talk
  attr_reader :over, :turn, :breaker, :pegs

  def initialize
    @over = false
    @turn = 12
    greet
    @breaker = take_input
    @breaker && @code = pick_random_colors || @code = take_input
    @guess = nil
    @pegs = ALL_WRONG
  end

  def announce_turns
    puts "There are #{@turn} turns remaining."
  end

  private

  attr_reader :code
  attr_writer :over, :pegs

  def pick_random_colors
    Array.new(4) { COLORS.sample }
  end

  def check_code
    @guess.each_with_index do |color, index|
      color == @code[index] && @pegs[index] = 'c'
      @code.include?(color) && @pegs[index] = 'o' || @pegs[index] = 'x'
    end
  end

  def give_pegs
    check_code
    @pegs
  end

  def take_turns(board)
    reminder
    until game_over?
      announce_turns
      puts board
      guess = take_input
      board.record_guess(@turn, guess.join(''), feedback.feedback.join(''))
      correct? ? end_game : continue
      @turn -= 1
      out_of_turns? ? end_game : next
    end
  end

  def correct?
    @code == guess.chars
  end

  def out_of_turns?
    @turn.zero?
  end

  def game_over?
    @over
  end

  def end_game
    @over = true
    # if @breaker = true, display final board
    # if !@breaker, display computer results, final board
  end
end

board = Board.new
game = Game.new

game.breaker ? game.take_turns(board) : display_computer_results
