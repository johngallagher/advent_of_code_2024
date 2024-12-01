require 'minitest/autorun'
require_relative 'calculate_total'

class CalculateTotalTest < Minitest::Test
  def test_returns_difference_of_zero_between_two_equal_numbers
    input = StringIO.new("5 5")
    total = CalculateTotal.new.call(input: input)
    assert_equal 0, total
  end

  def test_returns_difference_of_one_between_two_numbers_that_are_close
    input = StringIO.new("5 6")
    total = CalculateTotal.new.call(input: input)
    assert_equal 1, total
  end

  def test_returns_difference_when_first_number_is_larger_than_second
    input = StringIO.new("6 5")
    total = CalculateTotal.new.call(input: input)
    assert_equal 1, total
  end
end
