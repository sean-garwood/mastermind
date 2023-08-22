# output to console
module Talk
  def greet
    puts "---------Welcome to Mastermind!---------\n"
    describe_board
    describe_object
    provide_legend
  end

  def describe_board
    puts 'The board is twelve rows by eight columns: four columns each for the'
    puts 'previous guesses on the left, and four columns containing feedback'
    puts 'for those guesses.'
  end

  def describe_object
    puts '---------Object of game---------'
    puts 'You have twelve turns to guess the correct code, which may contain'
    puts 'duplicate values. You will be provided feedback at the end of each'
    puts 'turn. See the legend for details'
  end

  def provide_legend
    puts '---------Legend---------'
    puts '---------Color pegs---------'
    puts '----represent the color of the guess----'
    puts 'r: Red'
    puts 'o: Orange'
    puts 'y: Yellow'
    puts 'g: Green'
    puts 'b: Blue'
    puts 'v: Violet'
    puts '---------Guess pegs---------'
    puts 'x - incorrect color and position'
    puts 'o - correct color, incorrect position'
    puts 'c - correct color and position'
  end

  def reminder
    puts 'Enter your guess as a string of four letters. Order matters!'
  end

  def bad_end
    puts '----Oh no!----'
  end

  def good_end
    puts '----Yay!----'
  end
end
