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
end

game = Game.new

puts game.guess.join('')
puts game.pegs.join('')
