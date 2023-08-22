# frozen_string_literal: true

# require 'pry-byebug'
require_relative 'talk'

# represent the board
class Board
  BLANK_ROW = '____ | xxxx'
  INITIAL_BOARD_STATE = Array.new(12) { String.new(BLANK_ROW) }

  attr_reader :board

  def initialize
    @board = INITIAL_BOARD_STATE
  end

  def record_guess(guess, turn, feedback)
    @board[turn] = "#{guess} | #{feedback.join('')}"
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
    @code = POSITIONS.map { COLORS.sample }
    @feedback = POSITIONS.map { 'x' }
    @over = false
    @turn = 12
  end

  def announce_turns
    puts "There are #{@turn} turns remaining."
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

  def last_four(guess)
    guess[-4..] || guess
  end

  def give_feedback(guess)
    guess = guess.chars
    check_code(guess)
    @feedback
  end

  def take_turns(board)
    until @over
      puts board
      reminder
      announce_turns
      guess = last_four(gets.chomp.downcase)
      end_game(guess) if guess.chars == @code
      board.record_guess(guess, @turn, give_feedback(guess))
      @turn -= 1
      out_of_turns? ? end_game(guess) : next
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
    @over = true
    turns = (@turn - 12).abs
    out_of_turns? ? bad_end : good_end
    puts "code: #{@code.join('')}\nguess: #{guess}"
    puts "Number of turns: #{turns}"
    exit
  end

  private

  attr_reader :code
end

game = Game.new
board = Board.new

game.take_turns(board)
