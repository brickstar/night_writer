require 'minitest/autorun'
require 'minitest/pride'
require './lib/night_writer'
require 'pry'


class NightWriterTest < Minitest::Test

  def setup
    @nw = NightWriter.new
  end

  def test_it_exists
    assert_instance_of NightWriter, @nw
  end

  def test_attributes
    assert_equal "0.....", @nw.dictionary["a"]
  end

  def test_translate_one_letter_to_braille
    assert_equal "00000.", @nw.translate_letter("q")
  end

  def test_translate_phrase_to_braille
    assert_equal ["0.00..", "0..0..", "0.0.0.", "0.0.0.", "0..00.", "......", ".000.0", "0..00.", "0.000.", "0.0.0.", "00.0.."], @nw.translate_phrase("hello world")
  end

  def test_grab_first_two_index_of_braille_array
    assert_equal [["0."], ["0."], ["0."], ["0."], ["0."], [".."], [".0"], ["0."], ["0."], ["0."], ["00"]], @nw.grab_first_two("hello world")
    assert_equal [["0."], ["0."], ["0."], ["0."], ["0."], [".."], [".0"], ["0."], ["0."], ["0."], ["00"]], @nw.first_row
  end
end
