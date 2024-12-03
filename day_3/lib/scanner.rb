class Scanner
  def call(input)
    a, b = input
            .gsub('mul(','')
            .gsub(')', '')
            .split(",")
            .map(&:to_i)
    a * b
  end
end