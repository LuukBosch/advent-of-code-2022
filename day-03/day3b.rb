letter_hash = [*'a'..'z', *'A'..'Z'].each_with_index.map{|l,i| [l, i+1]}.to_h
score = 0
File.readlines('input.txt', chomp: true).each_slice(3) do |set|
  common = set.map(&:chars).inject(:&).first
  score += letter_hash[common]
end
pp score