input = File.open('input.txt')

top_three_cals = []
cur_cal = 0
input.readlines.each do |line|
  if line == "\n"
    top_three_cals << cur_cal
    top_three_cals = top_three_cals.max(3)
    cur_cal = 0
  else
    cur_cal += line.to_i
  end
end

puts "Top 3 calories total: #{top_three_cals.sum}"
