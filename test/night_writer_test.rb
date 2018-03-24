require 'minitest/autorun'
require 'minitest/pride'
require './lib/night_writer'
require 'pry'


class NightWriterTest < Minitest::Test

  def setup
    @nw = NightWriter.new
  end

  def test_it_exists
    skip
    assert_instance_of NightWriter, @nw
  end

  def test_attributes
    skip
    assert_equal "0.....", @nw.dictionary["a"]
  end

  def test_translate_one_letter_to_braille
    skip
    assert_equal "00000.", @nw.translate_letter("q")
  end

  def test_translate_phrase_to_braille
    skip
    assert_equal ["0.00..", "0..0..", "0.0.0.", "0.0.0.", "0..00.", "......", ".000.0", "0..00.", "0.000.", "0.0.0.", "00.0.."], @nw.translate_phrase("hello world")
  end

  def test_grab_first_two_index_of_braille_array
    skip
    assert_equal [["0."], ["0."], ["0."], ["0."], ["0."], [".."], [".0"], ["0."], ["0."], ["0."], ["00"]], @nw.grab_first_two("Hello, World!?")
    assert_equal [["0."], ["0."], ["0."], ["0."], ["0."], [".."], [".0"], ["0."], ["0."], ["0."], ["00"]], @nw.first_row
  end

  def test_grab_second_two_index_of_braille_array
    skip
    assert_equal  [["00"], [".0"], ["0."], ["0."], [".0"], [".."], ["00"], [".0"], ["00"], ["0."], [".0"]], @nw.grab_second_two("Hello, World!?")
    assert_equal  [["00"], [".0"], ["0."], ["0."], [".0"], [".."], ["00"], [".0"], ["00"], ["0."], [".0"]], @nw.second_row
  end

  def test_grab_third_two_index_of_braille_array
    skip
    assert_equal  [[".."], [".."], ["0."], ["0."], ["0."], [".."], [".0"], ["0."], ["0."], ["0."], [".."]], @nw.grab_third_two("Hello, World!?")
    assert_equal  [[".."], [".."], ["0."], ["0."], ["0."], [".."], [".0"], ["0."], ["0."], ["0."], [".."]], @nw.third_row
  end

  def test_convert_capitals
    assert_equal [".....0", "0.00..", "0..0..", "0.0.0.", "0.0.0.", "0..00.", "......", ".....0", ".000.0", "0..00.", "0.000.", "0.0.0.", "00.0.."], @nw.translate_phrase("Hello World")
  end

  def test_convert_special_characters
    assert_equal ["......", "..00.0", "..0...", "..000.", "..0.00", "....00"], @nw.translate_phrase(" .,!?-")
  end

end
