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
      do_operations = []
      dont_operations = []
      input
        .split(%r{(don't\(\)|do\(\))})
        .each do |value|
          if value == "do()"
            current_operation = :do
          elsif value == "don't()"
            current_operation = :dont
          elsif current_operation == :do
            do_operations << value
          elsif current_operation == :dont
            dont_operations << value
          else
            throw "Never get here"
          end
        end
      do_operations
    end
  end
end