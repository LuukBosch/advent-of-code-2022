def is_visible?(trees, x, y)
  return true if x == 0 || x == (trees.size-1)
  return true if y == 0 || y == (trees.size-1)
  return true if ((x + 1)..(trees.size-1)).all?{trees[y][_1] < trees[y][x]} #right
  return true if (0..(x-1)).all?{trees[y][_1] < trees[y][x]}                #left
  return true if ((y + 1)..(trees.size-1)).all?{trees[_1][x] < trees[y][x]} #bottom
  return true if (0..(y-1)).all?{trees[_1][x] < trees[y][x]}                #top
  false
end
trees = []
File.readlines('input.txt', chomp: true).each do |line|
  trees << line.split(//).map(&:to_i)
end

score = 0
(0..(trees.size - 1)).each do |x|
  (0..(trees.size - 1)).each do |y|
    score += 1 if is_visible?(trees, x, y)
  end
end
pp score
