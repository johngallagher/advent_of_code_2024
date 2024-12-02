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

    def without_level_at_index(index)
      self.class.new(@levels.reject.with_index { |_, i| i == index })
    end

    def initialize(levels)
      @levels = levels
    end

    def safe?
      (levels_ascending? || levels_descending?) && adjacent_levels_are_within_limits?
    end

    def safe_with_problem_dampener?
      safe_statuses = []
      @levels.each_with_index do |_, index|
        safe_statuses << without_level_at_index(index).safe?
      end
      safe_statuses.any? { |safe| safe == true }
    end

    def levels_ascending?
      @levels.sort == @levels
    end
    
    def levels_descending?
      @levels.sort.reverse == @levels
    end

    def adjacent_levels_are_within_limits?
      @levels.each_cons(2).to_a.all? do |a, b|
        difference = (a - b).abs
        difference > 0 && difference < 4
      end
    end


  end
end