# frozen_string_literal = TRUE

# random guess generator
module Answer
  COLORS = %w[red orange yellow green blue violet].freeze
  POSITIONS = (0..3).freeze

  def generate_code
    code = {}
    POSITIONS.each { |position| guess[position] = COLORS.sample }
    code
  end
end

# instantiate a game
class Game
  include Answer

  def initialize()
    @turns = 12
  end

  def take_turn

  end

  def over?

  end
end

# instantiate guesses
class Guess
  def correct?
    guess == code
  end
end

class Player
  def initialize()

  end
end
