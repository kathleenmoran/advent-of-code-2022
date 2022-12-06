def first_marker
  datastream_buffer = File.open('input.txt').read

  count = 4
  (0).upto(datastream_buffer.length - 4) do |i|
    return count if datastream_buffer[i...i + 4].chars.uniq.length == 4

    count += 1
  end
end

puts "Character count: #{first_marker}"