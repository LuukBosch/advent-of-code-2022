letter_hash = [*'a'..'z', *'A'..'Z'].each_with_index.map{|l,i| [l, i+1]}.to_h
score = 0
File.readlines('input.txt', chomp: true).each do |line|
  common = line[0, line.size/2].chars & line[line.size/2..-1].chars
  score += letter_hash[common[0]]
end
pp score