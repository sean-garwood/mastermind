# frozen_string_literal: true

require_relative 'board'
require_relative 'code'
require_relative 'code_helper'
require_relative 'talk'

# instantiate a game. the user presses enter if they want to make the code, so
# if @maker = nil then maker = true
class Game < Code
  include CodeHelper
  include Talk
  attr_reader :over, :turn

  def initialize
    super
    @over = false
    @turn = 1
  end

  def play(board)
    until game_over?
      case breaker?
      when true
        human_game(board)
      else
        computer_game(board)
      end
    end
  end

  private

  attr_writer :over, :turn

  def out_of_turns?
    @turn == 12
  end

  def game_over?
    @over
  end

  def end_game
    @over = true
  end

  def human_game(board)
    puts board
    prompt_for_guess
    check_guess
    board.record_guess(@turn, @guess, @pegs)
    correct? ? end_game : nil
    @turn += 1
    out_of_turns? ? end_game : nil
  end

  def computer_game(board)
    # guessing algo
    hack_code
    board.record_guess(@turn, @guess, @pegs)
    correct? ? end_game : nil
    @turn += 1
    out_of_turns? ? end_game : nil
    # display results
  end
end

board = Board.new
game = Game.new
game.play(board)
puts board
