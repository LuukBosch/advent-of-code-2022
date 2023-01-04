def are_adjacent?(a, b)
  (a[0] - b[0]).abs + (a[1] - b[1]).abs + (a[2] - b[2]).abs == 1
end

cubes = File.read('input.txt', chomp: true).split("\n").map{_1.split(",").map(&:to_i)}

surface_count = cubes.map do |cube|
  6 - cubes.count{|possible_neighbour| are_adjacent?(cube, possible_neighbour)}
end.sum
pp surface_count
