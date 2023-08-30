# frozen_string_literal: true

# represent the board
class Board
  attr_reader :board

  def initialize
    @board = []
  end

  def readable(arr)
    arr == @board ? arr.join("\n") : arr.join('')
  end

  def record_guess(turn, guess, pegs)
    @board << "[Turn #{turn}]: #{readable(guess)} | #{readable(pegs)}"
  end

  def to_s
    <<~BOARD
      \n---------Board---------\n\n
      [turn #]  guess|feedback
      -------------------------
      #{readable(@board)}
    BOARD
  end

  private

  attr_writer :board
end
