score = 0
File.readlines('input.txt', chomp: true).each do |line|
  ranges = line.split(",").map{|pair| pair.split("-")}.map{|pair| pair[0].to_i..pair[1].to_i}
  score += 1 if ranges[0].cover?(ranges[1]) || ranges[1].cover?(ranges[0])
end
pp score