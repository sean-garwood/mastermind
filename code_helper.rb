# frozen_string_literal: true

# transform user input to translate code
module CodeHelper
  COLORS = %w[r o y g b v].freeze
  def last_four(input)
    input[-4..] || input
  end

  def take_input
    last_four(gets.chomp.downcase.chars)
  end

  def to_a(members, element)
    Array.new(members) { element }
  end

  def first_guess
    first_color = random_color
    color_pool = COLORS.reject { |color| color == first_color }
    second_color = color_pool.sample
    first_guess = []
    2.times { first_guess << first_color }
    2.times { first_guess << second_color }
    first_guess
  end

  def random_color
    COLORS.sample
  end

  def pick_random_colors
    to_a(4, COLORS.sample)
  end
end
