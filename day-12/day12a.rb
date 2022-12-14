require 'set'

def find_spots(matrix)
  spots = []
  start_point = nil
  end_point = nil
  matrix.each_with_index do |row, y|
    row.each_with_index do |spot, x|
      (start_point = [x, y]) and (matrix[y][x] = "a") if spot == "S"
      (end_point = [x, y]) and (matrix[y][x] = "z") if spot == "E"
      spots << [x,y]
    end
  end
  [spots.to_set, start_point, end_point]
end

def neighbours(current, points, matrix)
  neighbours = []
  [[current[0], current[1] + 1],
   [current[0] + 1, current[1]],
   [current[0], current[1] - 1],
   [current[0] - 1, current[1]]
  ].each do |potential|
    next unless  points.include?(potential)
    next unless (matrix[potential[1]][potential[0]].ord - matrix[current[1]][current[0]].ord) <= 1
    neighbours << potential
  end
  neighbours
end

def shortest_path_to_end_point(matrix)
  points, start_point, end_point = find_spots(matrix)

  unvisited = points.clone.to_set
  shortest_distances = unvisited.each_with_object({}){_2[_1] = Float::INFINITY}
  shortest_distances[start_point] = 0

  while unvisited.size > 0
    current = shortest_distances.
      sort_by{|_,v| v}.
      find{unvisited.include?(_1[0])}[0]
    unvisited.delete(current)

    neighbours(current, points, matrix).each do |neighbour|
      distance = shortest_distances[current] + 1
      shortest_distances[neighbour] = distance if distance < shortest_distances[neighbour]
    end
  end
  shortest_distances[end_point]
end

matrix = []
File.readlines('input.txt', chomp: true).each do |line|
  matrix << line.split(//)
end
pp shortest_path_to_end_point(matrix)