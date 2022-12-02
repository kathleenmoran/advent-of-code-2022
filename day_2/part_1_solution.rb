def win?(opp_code, my_code)
  win_code = { 'X' => 'C', 'Y' => 'A', 'Z' => 'B' }
  win_code[my_code] == opp_code
end

def tie?(opp_code, my_code)
  tie_code = { 'X' => 'A', 'Y' => 'B', 'Z' => 'C' }
  tie_code[my_code] == opp_code
end

def outcome_score(opp_code, my_code)
  if win?(opp_code, my_code)
    6
  elsif tie?(opp_code, my_code)
    3
  else
    0
  end
end

def total_score
  input = File.open('input.txt')
  move_value = { 'X' => 1, 'Y' => 2, 'Z' => 3 }

  input.readlines.reduce(0) do |total, codes|
    codes = codes.split(' ')
    total + outcome_score(codes[0], codes[1]) + move_value[codes[1]]
  end
end

puts "Total score: #{total_score}"
