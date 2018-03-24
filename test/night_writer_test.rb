require 'minitest/autorun'
require 'minitest/pride'
require './lib/night_writer'
require 'pry'


class NightWriterTest < Minitest::Test

  def setup
    @nightwriter = NightWriter.new
  end

  def test_it_exists
    assert_instance_of NightWriter, @nightwriter
  end

  def test_attributes
    assert_equal "0.....", @nightwriter.dictionary["a"]
  end

  def test_translate_one_letter_to_braille
    assert_equal "00000.", @nightwriter.translate_letter("q")
  end
end
