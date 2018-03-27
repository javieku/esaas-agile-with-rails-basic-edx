# When done, submit this entire file to the autograder.

# Part 1

def sum(arr)
  puts "It's this my code?"
  result = 0
  arr.each { |x| result += x }
  result
end

def max_2_sum(arr)
  return 0 if arr.empty?
  return arr[0] if arr.count == 1
  arr.sort! { |x, y| y <=> x }
  arr[0] + arr[1]
end

def sum_to_n?(arr, n)
  return false if arr.count <= 2
  result = max_2_sum arr
  result >= n
end

# Part 2

def hello(name)
  "Hello, #{name}"
end

def starts_with_consonant?(s)
  /\A[[a-w]&&[^aeiou]]/i.match(s)
end

def binary_multiple_of_4?(s)
  return false if s.empty?
  /^0*$|^[10]*00$/.match(s)
end

# Part 3

class BookInStock
  attr_accessor :price
  attr_accessor :isbn

  def initialize(isbn, price)
    raise ArgumentError, 'price can not be negative or zero' unless price > 0.0
    raise ArgumentError, 'isbn can not be empty' if isbn.empty?
    @price = price
    @isbn = isbn
  end

  def price_as_string
    '$' + format('%.2f', @price)
  end
end
