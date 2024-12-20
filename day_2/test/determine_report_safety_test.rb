require 'minitest/autorun'
require_relative '../lib/determine_report_safety'

class DetermineReportSafetyTest < Minitest::Test
  def test_determine_report_safety
    input = StringIO.new("1 2 3 4 5")
    result = DetermineReportSafety.new.call(input:)
    assert_equal 1, result
  end

  def test_when_numbers_are_not_descending_or_ascending_report_is_unsafe
    input = StringIO.new("1 3 2 4 5")
    result = DetermineReportSafety.new.call(input:)
    assert_equal 1, result
  end

  def test_when_numbers_are_descending_report_is_safe
    input = StringIO.new("5 4 3 2 1")
    result = DetermineReportSafety.new.call(input:)
    assert_equal 1, result
  end

  def test_when_difference_between_two_numbers_is_zero_report_is_unsafe
    input = StringIO.new("1 1 2 3 4")
    result = DetermineReportSafety.new.call(input:)
    assert_equal 1, result
  end

  def test_when_difference_between_two_numbers_is_four_report_is_unsafe
    input = StringIO.new("1 2 3 4 8")
    result = DetermineReportSafety.new.call(input:)
    assert_equal 1, result
  end

  def test_multiple_reports
    input = StringIO.new("1 2 3 4 8\n1 2 3 4 5")
    result = DetermineReportSafety.new.call(input:)
    assert_equal 2, result
  end

  def test_report_with_one_unsafe_level_pair_is_safe
    input = StringIO.new("1 2 3 4 8")
    result = DetermineReportSafety.new.call(input:)
    assert_equal 1, result
  end

  def test_report_with_two_unsafe_level_pairs_is_unsafe
    input = StringIO.new("1 4 3 4 8")
    result = DetermineReportSafety.new.call(input:)
    assert_equal 0, result
  end

  def test_example_provided
    input = StringIO.new(
      "7 6 4 2 1\n" \
      "1 2 7 8 9\n" \
      "9 7 6 2 1\n" \
      "1 3 2 4 5\n" \
      "8 6 4 4 1\n" \
      "1 3 6 7 9\n"
    )
    result = DetermineReportSafety.new.call(input:)
    assert_equal 4, result
  end
end
