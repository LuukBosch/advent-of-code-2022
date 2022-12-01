calories_per_elf = []
sum = 0
File.readlines('input.txt', chomp: true).each do |line|
  if line.empty?
    calories_per_elf  << sum
    sum = 0
  else
    sum += line.to_i
  end
end
calories_per_elf  << sum

pp "The elf with the most calories has: #{calories_per_elf.max} calories"
pp "The top 3 elfs with the most calories have: #{calories_per_elf.max(3).sum} calories in total"
