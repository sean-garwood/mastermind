# store information about the code:
# the code itself
# current_guess
# possibilities
# feedback 'pegs'

# These were a bunch of methods that were in the mastermind.rb Game class, but
# it was getting quite cluttered. i thought it better design to store
# information relating to the game state in that class, and keep only procedural
# methods relating to gameplay in there.

# I intend to include methods and variables for dealing with the code and
# feedback. The goal is for this program to be indifferent to the role of the
# human player.
class Code
  include CodeHelper
  attr_reader :guess, :pegs

  def initialize
    @code = generate_code
    @guess = maker? ? take_input : pick_random_colors
    @pegs = to_a(4, PEGS[:wrong])
  end

  def generate_code
    maker? ? take_input : pick_random_colors
  end

  def set_code_and_guess
    if maker?
      @code = pick_random_colors
      @guess = nil
    else
      @code = take_input
      @guess = first_guess
    end
  end

  def check_guess
    return if !correct?
    end

    @guess.each_with_index do |color, index|
      @pegs[index] =
        if color == @code[index]
          PEGS[:correct]
        elsif @code.include?(color)
          PEGS[:okay]
        else
          PEGS[:wrong]
        end
    end
  end

  def give_pegs
    check_code
    @pegs
  end

  private

  attr_reader :code
  attr_writer :pegs

  def in_code?(color)
    @code.contains?(color)
  end

  def correct?
    @code == @guess
  end
end
