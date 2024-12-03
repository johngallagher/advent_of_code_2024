class Scanner
  def call(input)
    input
      .scan(/mul\((\d+),(\d+)\)/)
      # .tap { |a| throw a }
      .map { |a, b| a.to_i * b.to_i }
      .sum
  end
end