require "./lib/night_reader"
require_relative "test_helper"
require "pry"

class NightReaderTest < Minitest::Test

def test_instance_of_night_reader
  braille_text = NightReader.new("...000")

  assert_instance_of Nightreader, braille_text
end






end
