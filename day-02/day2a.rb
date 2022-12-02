outcome = {"A Y" => 6, "B Z" => 6, "C X" => 6, "A X" => 3, "B Y" => 3, "C Z" => 3}
score_for_element = {"X" => 1, "Y" => 2, "Z" => 3}
score = 0
File.readlines('input.txt', chomp: true).each do |line|
  score += outcome.fetch(line, 0)
  score += score_for_element[line[2]]
end
pp score