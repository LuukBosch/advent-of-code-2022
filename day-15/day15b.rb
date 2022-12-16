require "set"

sensor_map = {}
File.readlines('input.txt', chomp: true).each do |line|
  postitions = line.scan(/-?\d+/).map(&:to_i)
  sensor_map[[postitions[0], postitions[1]]] = [postitions[2], postitions[3]]
end

def manhatten_distance(sensor, beacon)
  (sensor[0] - beacon[0]).abs + (sensor[1] - beacon[1]).abs
end

def covering_squares(sensor, manhatten_distance, set, target, max)
  if (sensor[1] - manhatten_distance).abs <= target || (sensor[1] + manhatten_distance).abs >= target
    reach = manhatten_distance - (sensor[1] - target).abs
    start_point = sensor[0] - reach < 0 ? 0 : sensor[0] - reach
    end_point = sensor[0] + reach > max ? max : sensor[0] + reach
    set << (start_point..end_point) if start_point < end_point
  end
end

def reduce(set)
  reduced_set = Set.new
  merged = Set.new
  any_thing_merged = false
  set.each_with_index do |range, i|
    has_merged = false
    next if merged.include?(range)
    set.each_with_index do |candidate, j|
      next if i == j
      if ranges_overlap?(range, candidate)
        reduced_set << ([range.begin, candidate.begin].min..[range.end, candidate.end].max)
        merged << candidate
        has_merged = true
        any_thing_merged = true
      end
    end
    reduced_set << range unless has_merged
  end
  reduced_set = reduce(reduced_set) if any_thing_merged
  reduced_set
end

def ranges_overlap?(range_a, range_b)
  range_b.begin <= range_a.end + 1 && range_a.begin + 1 <= range_b.end
end

max = 4000000
max.times do |i|
  set = Set.new
  sensor_map.each do |sensor, beacon|
    covering_squares(sensor, manhatten_distance(sensor, beacon), set , i, max)
  end
  set = reduce(set)
  pp set.first.end * 4000000 + i and break if set.size == 2
end
