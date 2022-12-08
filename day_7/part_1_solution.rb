@size = Hash.new(0)
@dir_stack = []

def change_dir(line)
  destination = line.split.last
  if destination == '..'
    @dir_stack.pop
  else
    @dir_stack.push((@dir_stack.last || []) + [destination])
  end
end

def add_file(line, dir = @dir_stack.last)
  file_size = line.split.first.to_i
  @size[dir] += file_size
  add_file(line, dir[0..-2]) if dir.length > 1
end

def parse_terminal_output
  terminal_output = File.open('input.txt')

  terminal_output.readlines.each do |line|
    if line.start_with?('$ cd')
      change_dir(line)
    elsif /\d+/.match?(line)
      add_file(line)
    end
  end
end

def deleted_directories_total_size
  parse_terminal_output
  @size.values.reduce(0) { |total, size| size <= 100_000 ? total + size : total }
end

puts "Total size of deleted directories: #{deleted_directories_total_size}"
