require 'minitest/autorun'

class StringCalculator
  def self.add(numbers)
    return 0 if numbers.empty?

    numbers = numbers.split(/,|\n/)
    numbers.map(&:to_i).sum

  end
end

puts StringCalculator.add("") # => 0
puts StringCalculator.add("1") # => 1
puts StringCalculator.add("1,5") # => 6

class StringCalculatorTest < Minitest::Test
  def test_add_with_empty_string
    assert_equal 0, StringCalculator.add("")
  end

  def test_add_with_one_number
    assert_equal 1, StringCalculator.add("1")
  end

  def test_add_with_two_numbers
    assert_equal 3, StringCalculator.add("1,2")
  end
end
