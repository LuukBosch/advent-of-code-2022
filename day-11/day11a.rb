Struct.new("Monkey", :number, :items, :operation, :operation_volume, :test, :if_true, :if_false, :count)
def perform(monkey, monkeys)
  monkey.items.each do |item|
    operation_volume = monkey.operation_volume.nil? ? item : monkey.operation_volume
    inspected_item = item.public_send(monkey.operation, operation_volume)
    after_bored = inspected_item/3
    to_be_selected_monkey = after_bored%monkey.test == 0 ? monkey.if_true : monkey.if_false
    monkeys.find{_1.number == to_be_selected_monkey}.items << after_bored
    monkey.count += 1
  end
  monkey.items = []
end
monkeys = []
File.read('input.txt', chomp: true).split("\n\n").each do |monkey|
  number, items, operation, test, if_true, if_false = *monkey.split("\n")
  monkeys << Struct::Monkey.new(
    number.scan(/\d+/)&.first.to_i,
    items.scan(/\d+/)&.map(&:to_i),
    operation.chars[23].to_sym,
    operation.scan(/\d+/)&.map(&:to_i).first,
    test.scan(/\d+/)&.first.to_i,
    if_true.scan(/\d+/)&.first.to_i,
    if_false.scan(/\d+/)&.first.to_i,
    0
  )
end

20.times do
  monkeys.each do |monkey|
    perform(monkey, monkeys)
  end
end
pp monkeys.map{_1.count}.max(2).inject(:*)
