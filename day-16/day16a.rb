require 'set'

def shortest_path_to_end_point(caves, start_point)
  unvisited = caves.map{_1.name}.to_set
  shortest_distances = unvisited.each_with_object({}){_2[_1] = Float::INFINITY}
  shortest_distances[start_point] = 0

  while unvisited.size > 0
    current = shortest_distances.
      sort_by{|_,v| v}.
      find{unvisited.include?(_1[0])}[0]
    unvisited.delete(current)

    caves.find{_1.name == current}.neighbours.each do |neighbour|
      distance = shortest_distances[current] + 1
      shortest_distances[neighbour] = distance if distance < shortest_distances[neighbour]
    end
  end
  shortest_distances
end


def longest_path_to_end_point(caves, start_point)
  unvisited = caves.map{_1.name}.to_set
  shortest_distances = unvisited.each_with_object({}){_2[_1] = Float::INFINITY}
  shortest_distances[start_point] = 0

  while unvisited.size > 0
    current = shortest_distances.
      sort_by{|_,v| v}.
      find{unvisited.include?(_1[0])}[0]
    unvisited.delete(current)

    caves.find{_1.name == current}.neighbours.each do |neighbour|
      distance = shortest_distances[current] + 1
      shortest_distances[neighbour] = distance if distance < shortest_distances[neighbour]
    end
  end
  shortest_distances
end

Struct.new("Cave", :name, :flow_rate, :neighbours)
caves = []
File.readlines('example.txt', chomp: true).each do |line|
  caves << Struct::Cave.new(
    line.scan(/[A-Z]{2}/).first,
    line.scan(/\d+/)&.map(&:to_i).first,
    line.scan(/[A-Z]{2}/)[1..-1]
  )
end
options = caves.select{_1.flow_rate != 0}.map{_1.name}

def gain(caves, current, to_visit)
  minutes = 1
  pressure = 0
  pressure_release = 0
  while minutes < 31
    next_cave = to_visit.shift
    if next_cave
      time_to_travel = shortest_path_to_end_point(caves, current)[next_cave]
      time_to_travel.times do
        pressure += pressure_release
        minutes += 1
        break if minutes == 31
      end
      pressure += pressure_release
      pressure_release += caves.find{_1.name == next_cave}.flow_rate
      current = next_cave
      minutes += 1
      break if minutes == 31
    end
    unless next_cave
      pressure += pressure_release
      minutes += 1
      break if minutes == 31
    end
  end
  pressure
end
test =[]
options.permutation.each do |option|
  test << gain(caves, "AA", option)
end
pp test.max


