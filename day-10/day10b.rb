x = 1
cycle = 1

def check_cycle(x, cycle)
  print [x - 1, x, x + 1].include?((cycle - 1) % 40) ? "#" : "."
  puts "" if [40,80,120,160,200,240].include?(cycle)
end

File.readlines('input.txt', chomp: true).each do |line|
  command, amount = *line.split(" ")
  case command
  when "noop"
    check_cycle(x, cycle)
    cycle += 1
  when "addx"
    2.times do
      check_cycle(x, cycle)
      cycle += 1
    end
    x += amount.to_i
  end
end


