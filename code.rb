# frozen_string_literal: true

# Code and feedback
class Code
  include CodeHelper
  attr_reader :guess, :pegs

  def initialize
    @maker = take_input
    @code = generate_code
    @guess = generate_first_guess
    @pegs = to_a(4, PEGS[:wrong])
  end

  def generate_code
    maker? ? take_input : pick_random_colors
  end

  def generate_first_guess
    maker? ? first_guess : take_input
  end

  def check_guess
    return if correct?

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

  def maker?
    @maker
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
