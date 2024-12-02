class DetermineReportSafety
  def call(input:)
    input
      .read
      .split("\n")
      .map { |text| Report.from_text(text) }
      .count { |report| report.safe_with_problem_dampener? }
  end

  class Report
    def self.from_text(text)
      new(text.split(" ").map(&:to_i))
    end

    def initialize(numbers)
      @numbers = numbers
    end

    def safe?
      numbers_are_ascending = @numbers.sort == @numbers
      numbers_are_descending = @numbers.sort.reverse == @numbers
      adjacent_numbers_are_within_limits = @numbers.each_cons(2).to_a.all? do |a, b|
        difference = (a - b).abs
        difference > 0 && difference < 4
      end

      (numbers_are_ascending || numbers_are_descending) && adjacent_numbers_are_within_limits
    end

    def safe_with_problem_dampener?
      new_report_without_first_number = Report.new(@numbers.reject.with_index { |_, index| index == 0 })
      new_report_without_second_number = Report.new(@numbers.reject.with_index { |_, index| index == 1 })
      new_report_without_third_number = Report.new(@numbers.reject.with_index { |_, index| index == 2 })
      new_report_without_fourth_number = Report.new(@numbers.reject.with_index { |_, index| index == 3 })
      new_report_without_fifth_number = Report.new(@numbers.reject.with_index { |_, index| index == 4 })
      new_report_without_first_number.safe? || new_report_without_second_number.safe? || new_report_without_third_number.safe? || new_report_without_fourth_number.safe? || new_report_without_fifth_number.safe?
    end
  end
end