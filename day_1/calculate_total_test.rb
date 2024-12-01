require 'minitest/autorun'
require_relative 'calculate_total'

class CalculateTotalTest < Minitest::Test
  def test_calculates_similarity_of_two_fives_as_five
    input = StringIO.new("5 5")
    total = CalculateTotal.new.call(input: input)
    assert_equal 5, total
  end

  def test_calculates_similarity_when_first_number_is_found_twice_in_second_column
    input = StringIO.new("5 5\n3 3")
    total = CalculateTotal.new.call(input: input)
    assert_equal 8, total
  end
end
