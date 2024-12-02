class DetermineReportSafety
  def call(input:)
    numbers = input.read.split(" ").map(&:to_i)
    numbers_are_ascending = numbers.sort == numbers
    numbers_are_descending = numbers.sort.reverse == numbers
    if numbers_are_ascending || numbers_are_descending
      [:safe]
    else
      [:unsafe]
    end
  end
end