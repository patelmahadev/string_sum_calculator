require 'minitest/autorun'

class StringCalculator
  def self.add(numbers)
    return 0 if numbers.empty?

    if numbers.start_with?("//")
      delimiter, numbers = numbers[2..].split("\n", 2)
      numbers = numbers.split(/#{Regexp.escape(delimiter)}|\n/)
    else
      numbers = numbers.split(/,|\n/)
    end

    negatives = numbers.select { |n| n.to_i < 0 }
    raise "negative numbers not allowed: #{negatives.join(", ")}" if negatives.any?
    numbers.map(&:to_i).sum
  end
end

puts StringCalculator.add("") # => 0
puts StringCalculator.add("1") # => 1
puts StringCalculator.add("1,5") # => 6
puts StringCalculator.add("4\n4,8") # => 16
puts StringCalculator.add("//;\n3;4") # => 7

# Uncomment the line below to see the exception for negative numbers
# puts StringCalculator.add("1,-2")

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

  def test_add_with_new_lines_between_numbers
    assert_equal 18, StringCalculator.add("7\n8,3")
  end

  def test_add_with_multiple_numbers
    assert_equal 15, StringCalculator.add("1,2,3,4,5")
  end

  def test_add_with_different_delimiter
    assert_equal 3, StringCalculator.add("//;\n1;2")
  end

  def test_add_with_negative_number_raises_exception
    assert_raises(RuntimeError) { StringCalculator.add("1,-2") }
  end

  def test_add_with_multiple_negative_numbers_raises_exception_and_shows_message
    exception = assert_raises(RuntimeError) { StringCalculator.add("3,-4,-5") }
    assert_match /negative numbers not allowed: -4, -5/, exception.message
  end
end
