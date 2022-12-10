@x = 1
@cycle = 0
@screen = [[]]
@pixel_pos = @x

def screen
  File.open('input.txt').readlines.each do |instruction|

    update_screen
    
    unless instruction == "noop\n"
      update_screen
      @x += instruction.split.last.to_i
    end
  end

  @screen.map(&:join).join("\n")
end

def update_screen
  @screen.last << (@cycle.between?(@x - 1, @x + 1) ? '#' : '.')
  @cycle += 1
  if @cycle % 40 == 0
    @screen << []
    @cycle = 0
  end
end

puts "Screen:\n#{screen}"