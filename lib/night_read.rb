require "./lib/night_reader"
require "pry"

nr = NightReader.new
braille = File.open('./lib/braille.txt', 'r')
input = braille.readlines
binding.pry
braille.close

# nr = NightReader.new
# message = File.new('./lib/original_message.txt','w')
# message.puts(nr.output(input))
# message.close
