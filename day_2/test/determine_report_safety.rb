require 'minitest/autorun'
require_relative '../lib/determine_report_safety'

class DetermineReportSafetyTest < Minitest::Test
  def test_determine_report_safety
    input = StringIO.new("1 2 3 4 5")
    result = DetermineReportSafety.new.call(input:)
    assert_equal [:safe], result
  end

  def test_when_numbers_are_not_descending_or_ascending_report_is_unsafe
    input = StringIO.new("1 3 2 4 5")
    result = DetermineReportSafety.new.call(input:)
    assert_equal [:unsafe], result
  end

  def test_when_numbers_are_descending_report_is_safe
    input = StringIO.new("5 4 3 2 1")
    result = DetermineReportSafety.new.call(input:)
    assert_equal [:safe], result
  end
end
