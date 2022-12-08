def max_scenic_score
  forest = File.open('input.txt').readlines.map { |line| line.chomp.split('').map(&:to_i) }
  trans_forest = forest.transpose

  max_scenic_score = 0
  forest.each_with_index do |row, r|
    row.each_with_index do |_tree, c|
      max_scenic_score = [max_scenic_score, scenic_score(r, c, forest, trans_forest)].max
    end
  end

  max_scenic_score
end

def scenic_score(row, col, forest, trans_forest)
  [forest[row][0...col].reverse, forest[row][col + 1..], trans_forest[col][0...row].reverse, trans_forest[col][row + 1..]]
    .map { |trees| visible_trees_count(trees, forest[row][col]) }.reduce(:*)
end

def visible_trees_count(trees, target_tree)
  count = 0
  prev_tree = -1
  trees.each do |tree|
    break if target_tree <= prev_tree

    count += 1
    prev_tree = tree
  end

  count
end

puts "Maximum scenic score #{max_scenic_score}"
