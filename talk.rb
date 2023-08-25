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
    legend = <<~LEGEND
      ---------Legend---------
      ---------Color pegs---------
      ----represent the color of the guess----
      r: Red
      o: Orange
      y: Yellow
      g: Green
      b: Blue
      v: Violet
      ---------Guess pegs---------
      x - incorrect color and position
      o - correct color, incorrect position
      c - correct color and position
    LEGEND

    puts legend
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
