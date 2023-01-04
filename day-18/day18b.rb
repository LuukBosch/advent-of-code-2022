require 'set'

def find_group(start, cubes)
  visited = Set.new() << start
  queue = [start]
  until queue.empty?
    s = queue.shift
    neighbours(s, cubes).each do |neighbour|
      unless visited.include?(neighbour)
        queue << neighbour
        visited << neighbour
      end
    end
  end
  visited
end

def neighbours(start, cubes)
  neighbours = []
  neighbours << [start[0], start[1], start[2] + 1] unless
    cubes.include?([start[0], start[1], start[2] + 1]) || start[2] + 1 > cubes.max_by{_1[2]}[2]
  neighbours << [start[0], start[1], start[2] - 1] unless
    cubes.include?([start[0], start[1], start[2] - 1]) || start[2] - 1 < 0
  neighbours << [start[0], start[1] + 1, start[2]] unless
    cubes.include?([start[0], start[1] + 1, start[2]]) || start[1] + 1 > cubes.max_by{_1[1]}[1]
  neighbours << [start[0], start[1] - 1, start[2]] unless
    cubes.include?([start[0], start[1] - 1, start[2]]) || start[1] - 1 < 0
  neighbours << [start[0] + 1, start[1], start[2]] unless
    cubes.include?([start[0] + 1, start[1], start[2]]) || start[0] + 1 > cubes.max_by{_1[0]}[0]
  neighbours << [start[0] - 1, start[1], start[2]] unless
    cubes.include?([start[0] - 1, start[1], start[2]]) || start[0] - 1 < 0
  neighbours
end


def are_adjacent?(a, b)
  (a[0] - b[0]).abs +
    (a[1] - b[1]).abs +
    (a[2] - b[2]).abs == 1
end


cubes = File.read('input.txt', chomp: true).split("\n").map{_1.split(",").map(&:to_i)}

groups = []
(0..cubes.max_by{_1[0]}[0]).each do |x|
  (0..cubes.max_by{_1[1]}[1]).each do |y|
    (0..cubes.max_by{_1[2]}[2]).each do |z|
      next if groups.any?{_1.include?([x,y,z])}
      next if cubes.include?([x,y,z])
      groups << find_group([x,y,z], cubes).to_a
    end
  end
end

trapped_bubbles = groups.select{!_1.include?([0,0,0])}.flatten(1)

bubble_surface_count = trapped_bubbles.map do |bubble|
  6 - trapped_bubbles.count{|possible_neighbour| are_adjacent?(bubble, possible_neighbour)}
end.sum

surface_count = cubes.map do |cube|
  6 - cubes.count{|possible_neighbour| are_adjacent?(cube, possible_neighbour)}
end.sum

pp surface_count - bubble_surface_count
