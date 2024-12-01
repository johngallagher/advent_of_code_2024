class CalculateTotal
  def call(input:)
    input
      .read
      .split("\n")
      .map { |line| line.split(" ").map(&:to_i) }
      .transpose
      .then do |first_col, second_col|
        first_col.inject(0) do |sum, first_col_value|
          sum + (second_col.count { |value| value == first_col_value } * first_col_value)
        end
      end
  end
end