def first_marker
  datastream_buffer = File.open('input.txt').read

  count = 14
  (0).upto(datastream_buffer.length - 14) do |i|
    return count if datastream_buffer[i...i + 14].chars.uniq.length == 14

    count += 1
  end
end

puts "Character count: #{first_marker}"