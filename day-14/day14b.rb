require 'set'

def fill_cave(cave)
  obstacles = cave.to_set
  count = 0
  bottom = cave.map{_1[1]}.max + 1
  until drop_sand(obstacles, bottom)
    count += 1
  end
  count
end

def drop_sand(obstacles, bottom)
  sand = [500, 0]
  until sand_blocked?(sand, obstacles, bottom)
    sand = move_down(sand, obstacles)
  end
  obstacles << sand
  obstacles.include?([500,0])
end

def sand_blocked?(sand, obstacles, bottom)
  obstacles.include?([sand[0], sand[1] + 1]) &&
    obstacles.include?([sand[0] - 1, sand[1] + 1]) &&
    obstacles.include?([sand[0] + 1, sand[1] + 1]) || sand[1] == bottom
end

def move_down(sand, obstacles)
  if !obstacles.include?([sand[0], sand[1] + 1])
    [sand[0], sand[1] + 1]
  elsif !obstacles.include?([sand[0] - 1, sand[1] + 1])
    [sand[0] - 1, sand[1] + 1]
  else
    [sand[0] +  1, sand[1] + 1]
  end
end


cave = []
File.readlines('input.txt', chomp: true).each do |line|
  line.split("->").map{_1.strip.split(",")}.each_cons(2) do |start_point, end_point|
    if start_point[0] == end_point[0]
      min = [start_point[1], end_point[1]].min.to_i
      max = [start_point[1], end_point[1]].max.to_i
      x = start_point[0].to_i
      (min..max).each do |y|
        cave << [x, y]
      end
    else
      min = [start_point[0], end_point[0]].min.to_i
      max = [start_point[0], end_point[0]].max.to_i
      y = start_point[1].to_i
      (min..max).each do |x|
        cave << [x, y]
      end
    end
  end
end

pp fill_cave(cave) + 1
