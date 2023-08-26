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
  include CodeHelper
  attr_reader :board

  def initialize
    @board = []
  end

  def record_guess(turn, guess, pegs)
    @board << "[Turn #{turn}]: #{guess} | #{pegs}"
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
  attr_reader :over, :turn, :breaker, :pegs

  def initialize
    @over = false
    @turn = 1
    greet
    @breaker = take_input
    @breaker && @code = pick_random_colors || @code = take_input
    @guess = nil
    @pegs = %w[x x x x]
  end

  def take_turns(board)
    reminder
    until game_over?
      puts board
      @guess = take_input
      board.record_guess(@turn, @guess.join(''), give_pegs.join(''))
      correct? ? end_game : nil
      @turn += 1
      out_of_turns? ? end_game : next
    end
  end

  def crack_code(board)
    possible_colors = COLORS.each { |color| }
    first_pair = COLORS.sample
    second_pair = COLORS.sample
    @guess = "#{first_pair}#{first_pair}#{second_pair}#{second_pair}"

    until game_over?

      #check guess > remove possibilities > modify guess

    end
  end

  private

  attr_reader :code
  attr_writer :over, :pegs

  def pick_random_colors
    Array.new(4) { COLORS.sample }
  end

  def check_code
    @guess.each_with_index do |color, index|
      if color == @code[index]
        @pegs[index] = 'c'
      elsif @code.include?(color)
        @pegs[index] = 'o'
      else
        @pegs[index] = 'x'
      end
    end
  end

  def give_pegs
    check_code
    @pegs
  end

  def correct?
    @code == @guess
  end

  def out_of_turns?
    @turn == 12
  end

  def game_over?
    @over
  end

  def end_game
    @over = true
    # if !@breaker, display computer results, final board
  end
end

board = Board.new
game = Game.new

game.breaker ? game.take_turns(board) : display_computer_results
