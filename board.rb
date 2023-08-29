# frozen_string_literal: true

# represent the board
class Board
  attr_reader :board

  def initialize
    @board = []
  end

  def record_guess(turn, guess, pegs)
    @board << "[Turn #{turn}]: #{guess} | #{pegs}"
  end

  def to_s
    "---------Board---------\n#{@board.join("\n")}"
  end

  private

  attr_writer :board
end
