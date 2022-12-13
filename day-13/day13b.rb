require 'json'
def compare(left, right)
  left.size.times do |i|
    next if i >= right&.size
    if left[i].kind_of?(Integer) && right[i].kind_of?(Integer)
      return false if left[i] > right[i]
      return true if left[i]< right[i]
    elsif left[i].kind_of?(Array) && right[i].kind_of?(Array)
      result = compare(left[i], right[i])
    elsif left[i].kind_of?(Integer)
      result = compare([left[i]], right[i])
    else
      result = compare(left[i], [right[i]])
    end
    return result unless result.nil?
  end
  return true if left.size < right.size
  return false if left.size > right.size
  nil
end

list = [[[2]], [[6]]]
File.readlines('input.txt', chomp: true).each do |line|
  next if line.empty?
  list << JSON.parse(line)
end

sorted =list.sort do |a, b|
  compare(a.clone,b.clone) ? -1 : 1
end

pp (sorted.find_index([[2]]) + 1) * (sorted.find_index([[6]]) + 1)
