def round_score(opp_code, outcome_code)
  round_value = { 'A' => { 'X' => 3, 'Y' => 4, 'Z' => 8 },
                  'B' => { 'X' => 1, 'Y' => 5, 'Z' => 9 },
                  'C' => { 'X' => 2, 'Y' => 6, 'Z' => 7 } }

  round_value[opp_code][outcome_code]
end

def total_score
  input = File.open('input.txt')

  input.readlines.reduce(0) do |total, codes|
    codes = codes.split(' ')
    total + round_score(codes[0], codes[1])
  end
end

puts "Total score: #{total_score}"
