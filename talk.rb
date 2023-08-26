# output to console
module Talk
  def greet
    puts "---------Welcome to Mastermind!---------\n"
    describe_board
    describe_object_of_game
    provide_legend
    choose_role
  end

  def choose_role
    role = <<~ROLE
      ---------Role---------
      Choose your role. Will you be a codemaker or a heartbreaker?
    ROLE
    puts role
  end

  def describe_board
    description = <<~DESC
      ----------The board----------
      The board is twelve rows by eight columns: four columns each for the
      previous guesses on the left, and four columns containing feedback
      for those guesses.
    DESC
    puts description
  end

  def describe_object_of_game
    object_of_game = <<~OBJ
      ---------Object of game---------
      You have twelve turns to guess the correct code, which may contain
      duplicate values. You will be provided feedback at the end of each
      turn. See the legend for details
    OBJ
    puts object_of_game
  end

  def color_legend
    color_legend = <<~LEGEND
      ---------Legend---------
      ---------Color pegs---------
      r: Red
      o: Orange
      y: Yellow
      g: Green
      b: Blue
      v: Violet
    LEGEND
    puts color_legend
  end

  def guess_legend
    guess_legend = <<~LEGEND
      ---------Guess pegs---------
      x - incorrect color and position
      o - correct color, incorrect position
      c - correct color and position
    LEGEND
    puts guess_legend
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

  def display_computer_results(guesses)
    puts 'Computer guesses:'
    guesses.each_with_index do |guess, i|
      puts "#{i + 1}. #{guess}"
    end
    puts 'Computers always win.'
  end
end
