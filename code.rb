# frozen_string_literal: true

# require 'pry-byebug'
require_relative 'code_helper'

# Code and feedback
class Code
  PEGS = { correct: 'c', okay: 'o', wrong: 'x' }
  include CodeHelper
  attr_reader :maker, :guess, :pegs

  def initialize
    greet
    @maker = take_input
    @code = generate_code
    @guess = generate_first_guess
    @pegs = []
    @pool = COLORS.map { |color| color }
  end

  def check_color(color, index)
    if color == @code[index]
      PEGS[:correct]
    elsif @code.include?(color)
      PEGS[:okay]
    else
      PEGS[:wrong]
    end
  end

  def check_guess
    @guess.each_with_index do |color, index|
      @pegs[index] = check_color(color, index)
    end
  end

  def breaker?
    @maker.empty?
  end

  private

  attr_accessor :code
  attr_writer :pegs

  def prompt_for_code
    prompt_user_for_code
    @code = take_input
  end

  def prompt_for_guess
    prompt_user_for_guess
    @guess = take_input
  end

  def generate_code
    breaker? ? pick_random_colors : prompt_for_code
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

  def generate_first_guess
    breaker? ? nil : first_guess
  end

  def drain_pool
    # check to see if any x in pegs and remove corresponding colors
    bad_guesses = @guess.each_with_index.reduce([]) do |excluded, (color, i)|
      @pegs[i] == 'x' ? excluded << color : next
    end
    @pool.select! { |color| bad_guesses.include?(color) } unless bad_guesses.nil?
  end

  def next_guess
    @guess.each_index do |i|
      @guess[i] = @pool.select unless @pegs[i] == PEGS[:correct]
    end
  end

  def hack_code
    guesses = [] << @guess
    check_guess
    drain_pool
    next_guess
  end

  def correct?
    @code == @guess
  end
end
