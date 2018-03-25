require_relative 'test_helper'
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
    expected = ["0.00..", "0..0..", "0.0.0.", "0.0.0.", "0..00.", "......", ".000.0", "0..00.", "0.000.", "0.0.0.", "00.0.."]
    actual = @nw.translate_phrase("hello world")

    assert_equal expected, actual
  end

  def test_grab_first_two_index_of_braille_array
    @nw.translate_phrase("Hello, World!?")

    expected = "..0.0.0.0.0........00.0.0.00...."

    assert_equal expected, @nw.grab_first_two
    assert_equal expected, @nw.first_row
  end

  def test_grab_second_two_index_of_braille_array
    @nw.translate_phrase("Hello, World!?")

    expected = "..00.00.0..00.....00.0000..0000."

    assert_equal expected, @nw.grab_second_two
    assert_equal expected, @nw.second_row
  end

  def test_grab_third_two_index_of_braille_array
    @nw.translate_phrase("Hello, World!?")

    expected = ".0....0.0.0......0.00.0.0...0.00"

    assert_equal expected, @nw.grab_third_two
    assert_equal expected, @nw.third_row
  end

  def test_convert_capitals
    expected = [".....0", "0.00..", "0..0..", "0.0.0.", "0.0.0.", "0..00.", "......", ".....0", ".000.0", "0..00.", "0.000.", "0.0.0.", "00.0.."]
    actual = @nw.translate_phrase("Hello World")

    assert_equal expected, actual
  end

  def test_convert_special_characters
    expected = ["......", "..00.0", "..0...", "------", "..000.", "..0.00", "....00", "....0."]
    actual = @nw.translate_phrase(" .,\n!?-'")

    assert_equal expected, actual
  end

  def test_mixed_caps_and_special_characters
    expected = [".....0", "0.00..", "0..0..", "..00.0", ".....0", "0.0.0.", "0.0.0.", ".....0", "0..00.", "..0.00", "....0.", "------", "....00", "......", ".000.0", ".....0", "0..00.", "..0...", "0.000.", ".....0", "0.0.0.", "00.0..", "..000."]
    actual = @nw.translate_phrase("He.LlO?'\n- wO,rLd!")

    assert_equal expected, actual
  end
end
