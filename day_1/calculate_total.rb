class CalculateTotal
  def call(input:)
    a, b = input.read.split(" ").map(&:to_i)
    (b - a).abs
  end
end