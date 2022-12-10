require 'set'

def calc_priority(rucksack)
  rucksack = rucksack.chars.each_slice((rucksack.size / 2)).to_a
  left_contents = rucksack[0].to_set
  error = rucksack[1].find { |right_item| left_contents.include?(right_item) }
  /[[:lower:]]/ =~ error ? error.ord - 96 : error.ord - 38
end

def calc_priority_sum
  input = File.open('input.txt')

  input.readlines.reduce(0) do |total, rucksack|
    total + calc_priority(rucksack)
  end
end

puts "Priority total: #{calc_priority_sum}"
