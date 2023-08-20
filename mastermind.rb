# frozen_string_literal: true

# output to console
module Talk
  def prompt_for_username
    puts 'Please enter your username.'
  end

  def greet
    puts "---------Welcome to Mastermind!---------\n"
    describe_board
    describe_object
    provide_legend
    prompt_for_username
  end

  def describe_board
    puts 'The board is twelve rows by eight columns: four columns each for the'
    puts 'previous guesses on the left, and four columns containing feedback'
    puts 'for those guesses.'
  end

  def describe_object
    puts '---------Object of game---------'
    puts 'You have twelve turns to guess the correct code, which may contain'
    puts 'duplicate values. You will be provided feedback at the end of each'
    puts 'turn. See the legend for details'
  end

  def provide_legend
    puts '---------Legend---------'
    puts 'r: Red'
    puts 'o: Orange'
    puts 'y: Yellow'
    puts 'g: Green'
    puts 'b: Blue'
    puts 'v: Violet'
  end
end

# represent the board
class Board
  BLANK_ROW = '_ _ _ _ | x x x x'
  INITIAL_BOARD_STATE = Array.new(12, BLANK_ROW)

  def initialize
    @board = INITIAL_BOARD_STATE
  end

  def to_s
    "---------Board---------\n#{board}"
  end
end

# instantiate a game
class Game
  include Talk
  COLORS = %w[r o y g b v].freeze
  POSITIONS = (0..3).freeze

  def initialize
    greet
    @player = gets.chomp
    @turns = 12
    @code = generate_code
  end

  def generate_code
    code = {}
    POSITIONS.each { |position| code[position] = COLORS.sample }
    code
  end

  def guess_code(guess)
    # guess will be a string of four letters--each representing a position and
    # color in the position.
  end

  def take_turn
    # procedural code
    @turns -= 1
  end

  def over?
    @turns.zero? || correct?
  end

  private

  attr_reader :code
end

game = Game.new
board = Board.new

puts board
