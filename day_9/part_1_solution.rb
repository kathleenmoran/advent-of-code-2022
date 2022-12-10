require 'matrix'
require 'set'

def count_tail_positions
  t_pos = Vector[0, 0]
  h_pos = Vector[0, 0]
  uniq_tail_positions = Set.new

  File.open('input.txt').readlines.each do |move|
    direction, steps = move.split

    steps.to_i.times do
      h_pos = new_pos(h_pos, direction)
      t_pos = new_t_pos(t_pos, h_pos, direction)
      uniq_tail_positions.add(t_pos)
    end
  end

  uniq_tail_positions.length
end

def touching?(t_pos, h_pos)
  (t_pos - h_pos).all? { |coord| coord.between?(-1, 1) }
end

def new_pos(pos, direction)
  transformation = { 'L' => Vector[-1, 0], 'R' => Vector[1, 0], 'D' => Vector[0, 1 * -1], 'U' => Vector[0, 1] }
  pos + transformation[direction]
end

def new_diag_pos(t_pos, h_pos)
  transformation = (h_pos - t_pos).map { |coord| coord.positive? ? 1 : -1 }
  t_pos + transformation
end

def new_t_pos(t_pos, h_pos, direction)
  if touching?(t_pos, h_pos)
    t_pos
  elsif t_pos[0] == h_pos[0] || t_pos[1] == h_pos[1]
    new_pos(t_pos, direction)
  else
    new_diag_pos(t_pos, h_pos)
  end
end

puts "Tail positions count: #{count_tail_positions}"
