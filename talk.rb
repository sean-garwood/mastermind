# frozen_string_literal: true

# output to console
module Talk
  def greet
    puts "---------Welcome to Mastermind!---------\n"
    describe_board
    describe_object_of_game
    show_legends
    choose_role
  end

  def choose_role
    role = <<~ROLE
      ---------Role---------\n
      Choose your role. Will you be a codemaker or a heartbreaker?\n
      (press Enter to be the breaker, anything else to watch the computer
      wreck your code.)\n
    ROLE
    puts role
  end

  def describe_board
    description = <<~DESC
      ----------The board----------\n
      The board is twelve rows by eight columns: four columns each for the
      previous guesses on the left, and four columns containing feedback
      for those guesses.\n
    DESC
    puts description
  end

  def describe_object_of_game
    object_of_game = <<~OBJ
      ---------Object of game---------\n
      You have twelve turns to guess the correct code, which may contain
      duplicate values. You will be provided feedback at the end of each
      turn. See the legend for details.\n
    OBJ
    puts object_of_game
  end

  def show_color_legend
    color_legend = <<~LEGEND
      ---------Legend---------\n
      ---------Color pegs---------\n
      r: Red, o: Orange, y: Yellow, g: Green, b: Blue, v: Violet\n
    LEGEND
    puts color_legend
  end

  def show_guess_legend
    guess_legend = <<~LEGEND
      ---------Guess pegs---------\n
      x - incorrect color and position
      o - correct color, incorrect position
      c - correct color and position\n
    LEGEND
    puts guess_legend
  end

  def show_legends
    show_color_legend
    show_guess_legend
  end

  def prompt_user_for_code
    puts "\nEnter the secret code of colors. Order matters!\n\n"
  end

  def prompt_user_for_guess
    puts "\nEnter your guess as a string of four letters. Order matters!\n\n"
  end
end
