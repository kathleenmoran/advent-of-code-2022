@x = 1
@cycle = 1
@signal_sum = 0

def sum_interesting_signal_strengths
  File.open('input.txt').readlines.each do |instruction|
    break if @cycle > 220

    update_cycle_and_total
    
    unless instruction == "noop\n"
      @x += instruction.split.last.to_i
      update_cycle_and_total
    end
  end

  @signal_sum
end

def update_cycle_and_total
  @cycle += 1
  @signal_sum += (@x * @cycle) if (@cycle + 20) % 40 == 0
end

puts "Interesting signal strengths sum: #{sum_interesting_signal_strengths}"