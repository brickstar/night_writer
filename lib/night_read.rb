require "./lib/night_reader"

braille = File.open('./lib/braille.txt', 'r')
input = braille.read.delete("\n")
braille.close

nr = NightReader.new
message = File.new('./lib/message.txt','w')
message.puts(nw.output(input))
message.close
