def get_stack_and_instructions
  stack = Hash.new { |h, k| h[k] = [] }
  instruction_set = []
  instructions = false
  File.readlines('input.txt', chomp: true).each do |line|
    line.chars.each_slice(4).with_index do |crate, index|
      next if crate[1].strip.empty? || crate[1].match(/^(\d)+$/)
      stack[index + 1] << crate[1]
    end unless instructions

    (instructions = true) and next if line.empty?
    next unless instructions

    instruction_set << line.scan(/\d+/)&.map(&:to_i)
  end
  [stack, instruction_set]
end


def crate_mover(stack, instruction_set, type)
  instruction_set.each do |count, from, to|
    stack_to_move = stack[from].shift(count)
    case type
    when "9000"
      stack[to].unshift(*stack_to_move.reverse)
    when "9001"
      stack[to].unshift(*stack_to_move)
    end
  end
  stack.keys.length.times.map{|i| stack[i+1].first}.join
end

pp "CrateMover 9000: #{crate_mover(*get_stack_and_instructions, "9000")}"
pp "CrateMover 9001: #{crate_mover(*get_stack_and_instructions, "9001")}"
