require "./lib/night_reader"

braille = File.open('./lib/braille.txt', 'r')
input = braille.read.delete("\n")
braille.close

nr = NightReader.new
message = File.new('./lib/original_message.txt','w')
message.puts(nr.output(input))
message.close
