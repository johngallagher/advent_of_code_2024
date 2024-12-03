require 'minitest/autorun'
require 'scanner'

class ScannerTest < Minitest::Test
  def test_multiplies_two_numbers
    result = Scanner.new.call('mul(1,1)')
    assert_equal 1, result
  end

  def test_multiplies_two_numbers_non_trivially
    result = Scanner.new.call('mul(2,1)')
    assert_equal 2, result
  end

  def test_ignores_invalid_operations
    result = Scanner.new.call('mul(2,)')
    assert_equal 0, result
  end

  def test_garbage_before_and_after_extracts_valid_mult
    result = Scanner.new.call('xmul(2,4)%')
    assert_equal 8, result
  end

  def test_example_string
    result = Scanner.new.call('xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))')
    assert_equal 161, result
  end

  def test_extracts_two_mul_next_to_each_other
    result = Scanner.new.call('mul(11,8)mul(8,5)')
    assert_equal 128, result
  end

  def test_complex_example
    result = Scanner.new.call(complex_example)
    assert_equal 1736748, result
  end
  
  def test_newlines
    result = Scanner.new.call("mul(1,2)\nmul(1,2)")
    assert_equal 4, result
  end

  def test_example_with_donts_with_call
    result = Scanner.new.call("xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))")
    assert_equal 48, result
  end

  def test_splitting_on_do_or_dont_with_more_characters
    result = Scanner.new.remove_disabled_instructions.call("ado()bbdon't()c")
    assert_equal ["a", "bb"], result
  end

  def test_several_donts_in_a_row
    result = Scanner.new.remove_disabled_instructions.call("ado()bbdon't()cdon't()d")
    assert_equal ["a", "bb"], result
  end

  def test_example_with_donts
    result = Scanner.new.remove_disabled_instructions.call("xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))")
    assert_equal ["xmul(2,4)&mul[3,7]!^", "?mul(8,5))"], result
  end

  private

  def complex_example
    File.read('test/fixtures/complex.txt')
  end
end
