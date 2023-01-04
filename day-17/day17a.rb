
def print_blocks(stack, block)
  sleep(0.2)
  system('clear')
  (stack.values.flatten.max + 7).downto(0).each do |y|
    (-1..7).each do |x|
      if y == 0
        print "-"
      elsif x == -1 || x == 7
        print "|"
      elsif stack[x].include?(y)
        print "#"
      elsif block.include?([x,y])
        print "@"
      else
        print "."
      end
    end
    puts ""
  end
end

def not_blocked(block, stack)
  block.each do |cube|
    return false if stack[cube[0]].include?(cube[1] - 1)
  end
  true
end

def can_move_right?(block, stack)
  block.each do |cube|
    return false if cube[0] == 6
    return false if stack[cube[0] + 1].include?(cube[1])
  end
  true
end

def can_move_left?(block, stack)
  block.each do |cube|
    return false if cube[0] == 0
    return false if stack[cube[0] -1].include?(cube[1])
  end
  true
end

def perform_instruction(block, instruction, stack)
  case instruction
  when ">"
    if can_move_right?(block, stack)
      block.map!{[_1[0] + 1, _1[1]]}
    end
  when "<"
    if can_move_left?(block, stack)
      block.map!{[_1[0] - 1, _1[1]]}
    end
  end
end

def drop_block(block)
  block.map!{[_1[0], _1[1] - 1]}
end

def fix_block(block, stack)
  block.each do |cube|
    stack[cube[0]] << cube[1]
  end
end

blocks = [
  [[2, 0], [3, 0], [4, 0], [5, 0]],
  [[2, 1], [3, 0], [3, 1], [3, 2], [4, 1]],
  [[2, 0], [3, 0], [4, 0], [4, 1], [4, 2]],
  [[2, 0], [2, 1], [2, 2], [2, 3]],
  [[2, 0], [2, 1], [3, 0], [3, 1]]
]

instructions = File.read('example.txt', chomp: true).split(//)
stack = (0..6).each_with_object({}){_2[_1] = [0]}
printing = true

2022.times do
  block = blocks[0].map {|block| [block[0], block[1] + stack.values.flatten.max + 5] }
  print_blocks(stack, block) if printing
  while not_blocked(block, stack)
    drop_block(block)
    print_blocks(stack, block) if printing
    perform_instruction(block, instructions[0], stack)
    instructions.rotate!
    print_blocks(stack, block) if printing
  end
  fix_block(block, stack)
  print_blocks(stack, block) if printing
  blocks.rotate!
end
pp stack.values.flatten.max
