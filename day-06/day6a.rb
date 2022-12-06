def find_start(n)
  File.readlines('input.txt', chomp: true).each do |line|
    line.chars.each_cons(n).with_index do |buffer, index|
      return index + n if buffer.uniq.size == n
    end
  end
end
pp find_start(4)
pp find_start(14)