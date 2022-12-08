@children = Hash.new([])
@size = Hash.new(0)
@dir_stack = []

def change_dir(line)
  destination = line.split.last
  if destination == '..'
    @dir_stack.pop
  else
    @dir_stack.push(file_path(destination))
  end
end

def file_path(destination)
  if @dir_stack.last.nil?
    destination
  elsif @dir_stack.last == '/'
    "/#{destination}"
  else
    "#{@dir_stack.last}/#{destination}"
  end
end

def add_dir(line)
  @children[@dir_stack.last] += [file_path(line.split.last)]
end

def add_file(line, dir = @dir_stack.last)
  file_size = line.split.first.to_i
  @size[dir] += file_size
  add_file(line, parent(dir)) unless dir.empty? || dir == '/'
end

def start_with_int?(line)
  first = line.split.first
  first.to_i.to_s == first
end

def parent(dir)
  path = dir.split('/')
  path.pop
  parent = path.join('/')
  parent.empty? ? '/' : parent
end

def parse_terminal_output
  terminal_output = File.open('input.txt')

  terminal_output.readlines.each do |line|
    if line.start_with?('$ cd')
      change_dir(line)
    elsif line.start_with?('dir')
      add_dir(line)
    elsif start_with_int?(line)
      add_file(line)
    end
  end
end

def deleted_directories_total_size
  parse_terminal_output
  @size.values.sort.find { |file_size| 70_000_000 - @size['/'] + file_size >= 30_000_000 }
end

puts "Total size of deleted directory: #{deleted_directories_total_size}"