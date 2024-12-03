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
end