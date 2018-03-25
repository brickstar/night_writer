require "./lib/night_writer"

file = File.open('./lib/message.txt', 'r')
input = file.read.delete("\n")
file.close

nw = NightWriter.new
f = File.new('./lib/braille.txt','w')
f.puts(nw.output(input))
f.close
