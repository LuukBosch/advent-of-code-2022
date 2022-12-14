require 'set'

def print_cave(cave, resting_sand, sand)
  min_x = cave.map{_1[0]}.min - 2
  max_x = cave.map{_1[0]}.max + 2
  min_y = cave.map{_1[1]}.min - 4
  max_y = cave.map{_1[1]}.max + 2
  (min_y..max_y).each do |y|
    (min_x..max_x).each do |x|
      if cave.include?([x,y])
        print "#"
      elsif resting_sand.include?([x,y])
        print "o"
      elsif [x,y] == sand
        print "+"
      else
        print "."
      end
    end
    puts ""
  end
end

cave = []
File.readlines('example.txt', chomp: true).each do |line|
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

def fill_cave(cave)
  resting_sand = []
  obstacles = cave.clone.to_set
  count = 0
  until drop_sand(cave, resting_sand, obstacles)
    true
    count += 1
  end
  count
end

def drop_sand(cave, resting_sand, obstacles)
  sand = [500, 0]
  sand_blocked = false
  sand_infinity = false

  until sand_blocked  || sand_infinity
    sand = move_down(sand, obstacles)
    sleep(0.1)
    system('clear')
    print_cave(cave, resting_sand, sand)
    sand_blocked = sand_blocked?(sand, obstacles)
    sand_infinity = sand_infinity?(sand, obstacles)
  end
  resting_sand << sand unless sand_infinity
  obstacles << sand unless sand_infinity
  sand_infinity
end

def sand_blocked?(sand, obstacles)
  obstacles.include?([sand[0], sand[1] + 1]) &&
    obstacles.include?([sand[0] - 1, sand[1] + 1]) &&
      obstacles.include?([sand[0] + 1, sand[1] + 1])
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

def sand_infinity?(sand, obstacles)
  !obstacles.any? do |position|
    position[0] == sand[0] &&
      position[1] > sand[1]
  end

end

pp fill_cave(cave)
