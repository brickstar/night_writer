require "./lib/night_writer"

message = File.open('./lib/message.txt', 'r')
input = message.read
message.close

nw = NightWriter.new
braille = File.new('./lib/braille.txt', 'w')
braille.puts(nw.output(input))
puts "Created 'braille.txt' containing #{nw.braille_string.delete("\n").length} characters"
braille.close
