require 'set'

def calc_priority(rucksacks)
  rucksack1 = rucksacks[0].chars.to_set
  rucksack2 = rucksacks[1].chars.to_set
  badge = rucksacks[2].chars.find { |item| rucksack1.include?(item) && rucksack2.include?(item) }
  /[[:lower:]]/ =~ badge ? badge.ord - 96 : badge.ord - 38
end

def calc_priority_sum
  input = File.open('input.txt')

  total = 0
  input.readlines.each_slice(3) do |rucksacks|
    total += calc_priority(rucksacks)
  end

  total
end

puts "Badge priority total: #{calc_priority_sum}"
