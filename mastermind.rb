# frozen_string_literal = true

module Answer
  COLORS = {
    red: 0,
    orange: 1,
    yellow: 2,
    green: 3,
    blue: 4,
    violet: 5,
  }

  POSITIONS = [1, 2, 3, 4]

  def rng_answer
    color_index = (0..5).rand
    position_index = (0..3).rand
    [color_index, position_index]
  end
end

# instantiate a game
class Game

  include Answer
  @@turns_left = 12

  def initialize()

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
