outcome = {"A X" => "Z", "A Z" => "Y", "B Y" => "Y", "B Z" => "Z", "C X" => "Y", "C Y" => "Z"}
score_for_element = {"X" => 1, "Y" => 2, "Z" => 3}
score_for_result = {"X" => 0, "Y" => 3, "Z" => 6}
score = 0
File.readlines('input.txt', chomp: true).each do |line|
  score += score_for_element[outcome.fetch(line, "X")]
  score += score_for_result[line[2]]
end
pp score