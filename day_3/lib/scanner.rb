class Scanner
  def call(input)
    input
      .then(&remove_disabled_instructions)
      .flat_map do |operation|
        operation
          .scan(/mul\((\d+),(\d+)\)/)
          .map { |a, b| a.to_i * b.to_i }
      end.sum
  end

  def remove_disabled_instructions
    lambda do |input|
      current_operation = :do
      input
        .split(%r{(don't\(\)|do\(\))})
        .inject([]) do |operations, value|
          if value == "do()"
            current_operation = :do
            operations
          elsif value == "don't()"
            current_operation = :dont
            operations
          elsif current_operation == :do
            operations + [value]
          else
            operations
          end
        end
    end
  end
end