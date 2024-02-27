require 'minitest/autorun'

class StringCalculator
  def self.add(numbers)
    return 0 if numbers.empty?
  end
end

puts StringCalculator.add("") # => 0

class StringCalculatorTest < Minitest::Test
  def test_add_with_empty_string
    assert_equal 0, StringCalculator.add("")
  end
end
