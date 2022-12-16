require "set"

sensor_map = {}
File.readlines('input.txt', chomp: true).each do |line|
  postitions = line.scan(/-?\d+/).map(&:to_i)
  sensor_map[[postitions[0], postitions[1]]] = [postitions[2], postitions[3]]
end

def manhatten_distance(sensor, beacon)
  (sensor[0] - beacon[0]).abs + (sensor[1] - beacon[1]).abs
end

def add_sensor_covering_to_total_covering(sensor, manhatten_distance, total_covering, target)
  if (sensor[1] - manhatten_distance).abs <= target ||
       (sensor[1] + manhatten_distance).abs >= target
    reach = manhatten_distance - (sensor[1] - target).abs
    total_covering.merge(((sensor[0] - reach)..(sensor[0] + reach)).to_set)
  end
end

total_covering = Set.new
target = 2000000
sensor_map.each do |(sensor, beacon)|
  add_sensor_covering_to_total_covering(
    sensor,
    manhatten_distance(sensor, beacon),
    total_covering, target
  )
end

pp total_covering.size -
     sensor_map.values.uniq.count{_1[1] == target} -
     sensor_map.keys.uniq.count{_1[1] == target}