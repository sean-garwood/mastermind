# frozen_string_literal: true

require_relative 'code_helper'
require_relative 'talk'
require_relative 'board'

# instantiate a game. the user presses enter if they want to make the code, so
# if @maker = nil then maker = true
class Game
  include CodeHelper
  include Talk
  attr_reader :over, :turn, :maker, :pegs

  def initialize
    @over = false
    @turn = 1
    greet
    @maker = take_input
    @pegs = %w[x x x x]
    set_code_and_guess
  end

  # how a human plays the game
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

  def maker?
    @maker
  end

  private

  attr_reader :code
  attr_writer :over, :pegs

  def out_of_turns?
    @turn == 12
  end

  def game_over?
    @over
  end

  def end_game
    @over = true
    # if !@maker, display computer results, final board
  end
end

board = Board.new
game = Game.new

p game.first_guess
# game.maker ? game.take_turns(board) : display_computer_results
