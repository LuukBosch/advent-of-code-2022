snake = [[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0]]
@tail_positions = []

def move(head, tail, is_tail)
  if head[1] == tail[1]
    if (head[0] - tail[0]).abs >= 2
      (head[0] - tail[0]).positive? ? tail[0] += 1 : tail[0] -= 1

    end
  elsif head[0] == tail[0]
    if (head[1] - tail[1]).abs >= 2
      (head[1] - tail[1]).positive? ? tail[1] += 1 : tail[1] -= 1
    end
  elsif (head[1] - tail[1]).abs >= 2 || (head[0] - tail[0]).abs >= 2
    (head[0] - tail[0]).positive? ? tail[0] += 1 : tail[0] -= 1
    (head[1] - tail[1]).positive? ? tail[1] += 1 : tail[1] -= 1
  end
  @tail_positions << tail.clone if is_tail
end

def move_snake(snake)
  snake.each_cons(2).with_index do |snake_part, i|
    move(snake_part[0], snake_part[1], (i == snake.size - 2))
  end
end

File.readlines('input.txt', chomp: true).each do |line|
  direction, amount = line.split(" ")
  case direction
  when "R"
    amount.to_i.times do
      snake[0][0] += 1
      move_snake(snake)
    end
  when "L"
    amount.to_i.times do
      snake[0][0] -= 1
      move_snake(snake)
    end
  when "U"
    amount.to_i.times do
      snake[0][1] += 1
      move_snake(snake)
    end
  when "D"
    amount.to_i.times do
      snake[0][1] -= 1
      move_snake(snake)
    end
  end
end

pp (@tail_positions << [0,0]).uniq.count
