file_sizes = Hash.new { |h, k| h[k] = 0 }
current_path = ""

def process_command(folder, current_path)
  return "" if folder == "/"
  return current_path.split("/")[0..-2].join("/") if folder == ".."
  "#{current_path}/#{folder}"
end

def insert_file(current_path, file_sizes, size)
  file_sizes[current_path] += size.to_i
  return if current_path == ""

  insert_file(current_path.split("/")[0..-2].join("/"), file_sizes, size)
end

File.readlines('input.txt', chomp: true).each do |line|
  input = line.split(" ")
  if input[0] == "$" && input[1] != "ls"
    current_path = process_command(input[2], current_path)
  elsif input[0] != "dir"
    insert_file(current_path, file_sizes, input[0])
  end
end

#1
pp file_sizes.values.select{_1 <= 100000}.sum

#2
needed_space = 30000000 - (70000000 - file_sizes[""])
pp file_sizes.values.select{_1 >= needed_space}.sort.min
