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
    # ...
  end

  # ...more methods...

  private


  # ...private methods that read/write the code

end
