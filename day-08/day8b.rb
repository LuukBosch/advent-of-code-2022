def trees_visible_product(trees, x, y)
  right = tree_count_x(((x + 1)..(trees.size-1)), trees, x, y)
  left = tree_count_x((x-1).downto(0), trees, x, y)
  top = tree_count_y((((y + 1)..(trees.size-1))),trees, x, y)
  bottom =  tree_count_y((y-1).downto(0),trees, x, y)
  right*left*top*bottom
end

def tree_count_x(range, trees, x, y)
  score = 0
  range.each do |x_1|
    score += 1
    break if trees[y][x_1] >= trees[y][x]
  end
  score
end

def tree_count_y(range, trees, x, y)
  score = 0
  range.each do |y_1|
    score += 1
    break if trees[y_1][x] >= trees[y][x]
  end
  score
end

trees = []
File.readlines('input.txt', chomp: true).each do |line|
  trees << line.split(//).map(&:to_i)
end

score = []
(0..(trees.size - 1)).each do |x|
  (0..(trees.size - 1)).each do |y|
    score << trees_visible_product(trees, x, y)
  end
end
pp score.max
