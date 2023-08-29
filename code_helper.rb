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

  def random_color
    COLORS.sample
  end

  def pick_random_colors
    Array.new(4) { COLORS.sample }
  end
end
