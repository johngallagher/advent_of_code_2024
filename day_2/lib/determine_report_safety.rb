class DetermineReportSafety
  def call(input:)
    input
      .read
      .split("\n")
      .count { |text| Report.new(text).safe? }
  end

  class Report
    def initialize(text)
      @text = text
    end

    def safe?
      numbers = @text.split(" ").map(&:to_i)
      numbers_are_ascending = numbers.sort == numbers
      numbers_are_descending = numbers.sort.reverse == numbers
      adjacent_numbers_are_within_limits = numbers.each_cons(2).to_a.all? do |a, b|
        difference = (a - b).abs
        difference > 0 && difference < 4
      end

      (numbers_are_ascending || numbers_are_descending) && adjacent_numbers_are_within_limits
    end
  end
end