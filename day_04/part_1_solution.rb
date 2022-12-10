def overlaps?(pair)
  pair = pair.split(',').map { |range| range.split('-').map(&:to_i) }
  pair[0].all? { |n| n.between?(pair[1][0], pair[1][1]) } ||
    pair[1].all? { |n| n.between?(pair[0][0], pair[0][1]) }
end

def total_overlapping_pairs
  input = File.open('input.txt')

  input.readlines.reduce(0) do |total, pair|
    overlaps?(pair) ? total + 1 : total
  end
end

puts "Total partially overlapping pairs: #{total_overlapping_pairs}"
