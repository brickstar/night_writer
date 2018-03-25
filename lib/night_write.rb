require "./lib/night_writer"

message = File.open('./lib/message.txt', 'r')
input = message.read.delete("\n")
message.close

nw = NightWriter.new
braille = File.new('./lib/braille.txt','w')
braille.puts(nw.output(input))
braille.close
