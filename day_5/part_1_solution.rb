def move_crate(crates, move_text)
  quantity, start_col, end_col = move_text.scan(/\d+/).map(&:to_i)
  crates[end_col - 1] += crates[start_col - 1].pop(quantity).reverse
end

def parse_crates(crates_text)
  crates = Array.new((crates_text.lines.first.length + 1) / 4) { Array.new }
  crates_text.each_line do |line|
    break if line.start_with?(' 1')

    line.chars.each_slice(4).with_index do |crate_space, i|
      crate_space = crate_space.join('').strip
      crates[i].unshift(crate_space[1]) unless crate_space.empty?
    end
  end

  crates
end

def top_crates
  crates_text, moves_text = File.open('input.txt').read.split("\n\n")

  crates = parse_crates(crates_text)

  moves_text.each_line do |move_text|
    move_crate(crates, move_text)
  end

  crates.map(&:last).join('')
end

puts "Crates on the top row: #{top_crates}"




