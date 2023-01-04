def mod_floor(a,b)
  ((a % b) + b) % b
end

numbers = []
File.readlines('input.txt', chomp: true).each_with_index do |line, index|
  numbers << [line.to_i, index]
end
numbers_clone = numbers.clone

numbers_clone.each do |number|
  index = numbers.find_index(number)
  new_index = (mod_floor(number[0], numbers.size - 1) + index) % (numbers.size - 1)
  if new_index == 0
    new_index = numbers.size - 1
  elsif new_index == numbers.size - 1
    new_index = 0
  end
  numbers.insert(new_index, numbers.delete_at(index))
end

new_order = numbers.map!{_1[0]}
index_of_zero = new_order.find_index(0)
pp [1000,2000,3000].map{new_order[(index_of_zero + _1) % new_order.size]}.sum



