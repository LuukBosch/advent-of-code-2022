require 'set'

def find_spots(matrix)
  spots = []
  end_point = nil
  low_points = []
  matrix.each_with_index do |row, y|
    row.each_with_index do |spot, x|
      matrix[y][x] = "a" if spot == "S"
      (end_point = [x, y]) and (matrix[y][x] = "z") if spot == "E"
      low_points << [x,y] if spot == "a"
      spots << [x,y]
    end
  end
  [spots.to_set, end_point, low_points]
end

def neighbours(current, points, matrix)
  neighbours = []
  [[current[0], current[1] + 1],
   [current[0] + 1, current[1]],
   [current[0], current[1] - 1],
   [current[0] - 1, current[1]]
  ].each do |potential|
    next unless  points.include?(potential)
    next unless ( matrix[current[1]][current[0]].ord - matrix[potential[1]][potential[0]].ord) <= 1
    neighbours << potential
  end
  neighbours
end

def shortest_path_to_end_point(matrix)
  points, end_point, low_points = find_spots(matrix)

  unvisited = points.clone.to_set
  shortest_distances = unvisited.each_with_object({}){_2[_1] = Float::INFINITY}
  shortest_distances[end_point] = 0

  while unvisited.size > 0
    pp unvisited.count
    current = shortest_distances.
      sort_by{|_,v| v}.
      find{unvisited.include?(_1[0])}[0]
    unvisited.delete(current)

    neighbours(current, points, matrix).each do |neighbour|
      distance = shortest_distances[current] + 1
      shortest_distances[neighbour] = distance if distance < shortest_distances[neighbour]
    end
  end
  shortest_distances.select{|k,_| low_points.include?(k)}.sort_by{|_,v| v}[0][1]
end

matrix = []
File.readlines('input.txt', chomp: true).each do |line|
  matrix << line.split(//)
end

pp shortest_path_to_end_point(matrix)
