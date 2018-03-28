require "./lib/night_reader"
require_relative "test_helper"
require "pry"

class NightReaderTest < Minitest::Test

  def test_instance_of_night_reader
    nr = NightReader.new

    assert_instance_of NightReader, nr
  end

  def test_it_can_split_into_braille_into_three_rows

    nr = NightReader.new
    nr.split_into_rows(["..0.0.0.0.......0.0.0.0..0\n",
                        "..0..00..00.....0..00..00.\n",
                        ".00.0.00.......00.0.00....\n",
                        "..000.00..000....00.0..0..\n",
                        "..000.00..000....00.0..0..\n",
                        "..000.00..000....00.0..0..\n"])


  assert_equal ["..0.0.0.0.......0.0.0.0..0\n", "..000.00..000....00.0..0..\n"], nr.first_row
  assert_equal ["..0..00..00.....0..00..00.\n", "..000.00..000....00.0..0..\n"], nr.second_row
  assert_equal [".00.0.00.......00.0.00....\n", "..000.00..000....00.0..0..\n"], nr.third_row
  end

  def test_it_can_remove_return_keys_and_split_the_array_into_two_character_strings
    nr = NightReader.new
    nr.split_into_rows(["0000000000\n", "..........\n", "0.0.0.0.0.\n"])
    nr.scan_rows

    assert_equal ["00", "00", "00", "00", "00"], nr.first_row
    assert_equal ["..", "..", "..", "..", ".."], nr.second_row
    assert_equal ["0.", "0.", "0.", "0.", "0."], nr.third_row
  end

  def test_it_can_put_braille_back_in_order
    nr = NightReader.new

    nr.split_into_rows(["0000000000\n", "..........\n", "0.0.0.0.0.\n"])
    nr.scan_rows

    assert_equal "00..0.00..0.00..0.00..0.00..0.", nr.zip_rows
  end

  def test_it_can_cut_braille_into_characters
    nr = NightReader.new

    nr.split_into_rows(["0.0.0.0.0....00.0.0.00", "00.00.0..0..00.0000..0", "....0.0.0....00.0.0..."])
    nr.scan_rows
    nr.zip_rows

    assert_equal ["0.00..", "0..0..", "0.0.0.", "0.0.0.", "0..00.", "......", ".000.0", "0..00.", "0.000.", "0.0.0.", "00.0.."], nr.convert_to_braille_strings
  end

  def test_it_can_translate_letter
    nr = NightReader.new

    assert_equal "h", nr.translate_braille_letter("0.00..")
  end

  def test_it_can_translate_braille_phrase
    nr = NightReader.new

    nr.split_into_rows(["0.0.0.0.0....00.0.0.00", "00.00.0..0..00.0000..0", "....0.0.0....00.0.0..."])
    nr.scan_rows
    nr.zip_rows
    nr.convert_to_braille_strings

    assert_equal ["h", "e", "l", "l", "o", " ", "w", "o", "r", "l", "d"], nr.braille_to_eng
  end

  def test_it_can_convert_capital_letters
    nr = NightReader.new

    nr.split_into_rows(["..0.0.0.0.0....00.0.0.00", "..00.00.0..0..00.0000..0", ".0....0.0.0....00.0.0..."])
    nr.scan_rows
    nr.zip_rows
    nr.convert_to_braille_strings
    nr.braille_to_eng

    assert_equal ["%", "H", "e", "l", "l", "o", " ", "w", "o", "r", "l", "d"], nr.convert_capitals
  end

  def test_it_can_remove_cap_key
    nr = NightReader.new

    nr.split_into_rows(["..0.0.0.0.0....00.0.0.00", "..00.00.0..0..00.0000..0", ".0....0.0.0....00.0.0...", "..0.0.0.0.0....00.0.0.00", "..00.00.0..0..00.0000..0", ".0....0.0.0....00.0.0..."])
    nr.scan_rows
    nr.zip_rows
    nr.convert_to_braille_strings
    nr.braille_to_eng

    assert_equal ["", "H", "e", "l", "l", "o", " ", "w", "o", "r", "l", "d", "", "H", "e", "l", "l", "o", " ", "w", "o", "r", "l", "d"], nr.strip_capital_key
  end
end
