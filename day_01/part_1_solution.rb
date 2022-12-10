input = File.open('input.txt')

max_cal = 0
cur_cal = 0
input.readlines.each do |line|
  if line == "\n"
    max_cal = [max_cal, cur_cal].max
    cur_cal = 0
  else
    cur_cal += line.to_i
  end
end

puts "Max calories: #{max_cal}"
