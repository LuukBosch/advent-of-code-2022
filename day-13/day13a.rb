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

values = []
File.read('input.txt', chomp: true).split("\n\n").each_with_index do |set, index|
  left, right = *set.split("\n").map{JSON.parse(_1)}
  values << index + 1 if compare(left, right)
end
pp values.sum