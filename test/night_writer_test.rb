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
end
