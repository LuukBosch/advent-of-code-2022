score = 0
File.readlines('input.txt', chomp: true).each do |line|
  ranges = line.split(",").map{|pair| pair.split("-")}.map{|pair| pair[0].to_i..pair[1].to_i}
  overlap = ranges[0].to_a & ranges[1].to_a
  score += 1 if overlap.length > 0
end
pp score