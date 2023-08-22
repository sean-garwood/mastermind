# frozen_string_literal: true

# require 'pry-byebug'

# output to console
module Talk
  def greet
    puts "---------Welcome to Mastermind!---------\n"
    describe_board
    describe_object
    provide_legend
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
    puts '---------Color pegs---------'
    puts '----represent the color of the guess----'
    puts 'r: Red'
    puts 'o: Orange'
    puts 'y: Yellow'
    puts 'g: Green'
    puts 'b: Blue'
    puts 'v: Violet'
    puts '---------Guess pegs---------'
    puts 'x - incorrect color and position'
    puts 'o - correct color, incorrect position'
    puts 'c - correct color and position'
  end
end

# represent the board
class Board
  BLANK_ROW = '____ | xxxx'
  INITIAL_BOARD_STATE = Array.new(12) { String.new(BLANK_ROW) }

  attr_reader :board

  def initialize
    @board = INITIAL_BOARD_STATE
  end

  def record_guess(guess, turn, feedback)
    @board[turn] = guess + ' | ' + feedback.join('')
  end

  def to_s
    readable = @board.join("\n")
    "---------Board---------\n#{readable}"
  end

  private

  attr_writer :board
end

# instantiate a game
class Game
  include Talk
  COLORS = %w[r o y g b v].freeze
  POSITIONS = (0..3).freeze

  attr_accessor :feedback
  attr_reader :over, :player, :turns

  def initialize
    greet
    @code = POSITIONS.map { |e| COLORS.sample }
    @feedback = POSITIONS.map { |e| 'x' }
    @over = false
    @turn = 12
  end

  def announce_turns
    puts "There are #{@turn} turns remaining."
  end

  def last_four(guess)
    guess[-4..] || guess
  end

  def give_feedback(guess)
    guess = guess.chars
    guess.each_with_index do |char, index|
      if @code.include?(char) && char != @code[index]
        @feedback[index] = 'o'
      elsif char == @code[index]
        @feedback[index] = 'c'
      else
        @feedback[index] = 'x'
      end
    end
    @feedback
  end

  def take_turns(board)
    until @over
      puts board
      puts 'Enter your guess as a string of four letters. Order matters!'
      announce_turns
      guess = last_four(gets.chomp.downcase)
      end_game(guess) if guess.chars == @code
      board.record_guess(guess, @turn, give_feedback(guess))
      @turn -= 1
      out_of_turns? ? @over = true : next
    end
  end

  def correct?(guess)
    guess = guess.chars
    @code == guess ? @over = true : false
  end

  def out_of_turns?
    @turn.zero?
  end

  def end_game(guess)
    turns = -1 * @turn - 12 - 1
    puts "Congrats!\ncode: #{@code.join('')} / guess: #{guess}"
    puts "Number of turns: #{@turn}"
    exit
  end

  private

  attr_reader :code
end

game = Game.new
board = Board.new

game.take_turns(board)
