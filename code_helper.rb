
# transform user input to translate code
module CodeHelper
  COLORS = %w[r o y g b v].freeze
  def last_four(input)
    input[-4..] || input
  end

  def take_input
    last_four(gets.chomp.downcase.chars)
  end

  def make_into_array(members, element)
    Array.new(members) { element }
  end

  def first_guess
    pair = Array.new(2) { COLORS.sample }
    two_pair = Array.new(2) { pair }
    two_pair.flatten.sort
  end

  def pick_random_colors
    Array.new(4) { COLORS.sample }
  end
end
