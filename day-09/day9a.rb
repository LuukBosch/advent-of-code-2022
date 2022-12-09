head = [0,0]
tail = [0,0]
@tail_positions = []

def move_right(head, tail, amount)
  head[0] += amount
  if head[1] != tail[1] && (head[0] - tail[0]).abs >= 2
    tail[1] = head[1]
    tail[0] += 1
    @tail_positions << tail.clone
  end
  (tail[0] + 1).upto(head[0] - 1) do |x|
    tail[0] = x
    @tail_positions << tail.clone
  end
end

def move_left(head, tail, amount)
  head[0] -= amount
  if head[1] != tail[1] && (head[0] - tail[0]).abs >= 2
    tail[1] = head[1]
    tail[0] -= 1
    @tail_positions << tail.clone
  end
  (tail[0] - 1).downto(head[0] + 1) do |x|
    tail[0] = x
    @tail_positions << tail.clone
  end
end

def move_up(head, tail, amount)
  head[1] += amount
  if head[0] != tail[0] && (head[1] - tail[1]).abs >= 2
    tail[0] = head[0]
    tail[1] += 1
    @tail_positions << tail.clone
  end
  (tail[1] + 1).upto(head[1] - 1) do |x|
    tail[1] = x
    @tail_positions << tail.clone
  end
end

def move_down(head, tail, amount)
  head[1] -= amount
  if head[0] != tail[0] && (head[1] - tail[1]).abs >= 2
    tail[0] = head[0]
    tail[1] -= 1
    @tail_positions << tail.clone
  end
  (tail[1] - 1).downto(head[1] + 1) do |x|
    tail[1] = x
    @tail_positions << tail.clone
  end
end

File.readlines('input.txt', chomp: true).each do |line|
  direction, amount = line.split(" ")
  case direction
  when "R"
    move_right(head, tail, amount.to_i)
  when "L"
    move_left(head, tail, amount.to_i)
  when "U"
    move_up(head, tail, amount.to_i)
  when "D"
    move_down(head, tail, amount.to_i)
  end
end
pp (@tail_positions << [0,0]).uniq.count
