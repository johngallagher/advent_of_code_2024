class DetermineReportSafety
  def call(input:)
    input
      .read
      .split("\n")
      .count { |text| Report.from_text(text).safe_with_problem_dampener? }
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
      safe_statuses = []
      @numbers.each_with_index do |_, index|
        safe_statuses << Report.new(@numbers.reject.with_index { |_, i| i == index }).safe?
      end
      safe_statuses.any? { |safe| safe == true }
    end
  end
end