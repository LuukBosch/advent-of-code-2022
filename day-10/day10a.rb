x = 1
cycle = 1
@interesting_cycles_count = []

def check_cycle(x, cycle)
  @interesting_cycles_count << (x*cycle) if [20,60,100,140,180,220].include?(cycle)
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

pp @interesting_cycles_count.sum

