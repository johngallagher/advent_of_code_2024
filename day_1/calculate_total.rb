class CalculateTotal
  def call(input:)
    input
      .read
      .split("\n")
      .map { |line| line.split(" ").map(&:to_i) }
      .transpose
      .map { |row| row.sort }
      .transpose
      .map { |a, b| (b - a).abs }
      .sum
  end
end