
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

  def set_code_and_guess
    if maker?
      @code = pick_random_colors
      @guess = nil
    else
      @code = take_input
      @guess = first_guess
    end
  end

  def first_guess
    pair = to_a(2, COLORS.sample)
    two_pair = to_a(2, pair)
    two_pair.flatten.sort
  end

  def pick_random_colors
    to_a(4, COLORS.sample)
  end
end
