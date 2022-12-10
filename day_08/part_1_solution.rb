def visible_trees_count
  forest = File.open('input.txt').readlines.map { |line| line.chomp.split('').map(&:to_i) }
  trans_forest = forest.transpose

  visible_count = 0
  forest.each_with_index do |row, r|
    row.each_with_index do |_tree, c|
      visible_count += 1 if visible?(r, c, forest, trans_forest)
    end
  end

  visible_count
end

def visible?(row, col, forest, trans_forest)
  on_edge?(row, col, forest) || interior_visible?(row, col, forest, trans_forest)
end

def on_edge?(row, col, forest)
  [row, col].include?(0) || [row, col].include?(forest.length - 1)
end

def interior_visible?(row, col, forest, trans_forest)
  [forest[row][0...col], forest[row][col + 1..], trans_forest[col][0...row], trans_forest[col][row + 1..]]
    .map(&:max).any? { |tree| tree < forest[row][col] }
end

puts "Number of visible trees: #{visible_trees_count}"
