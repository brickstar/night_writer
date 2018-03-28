require_relative 'dictionary'
require 'pry'
# this is a NightWriter class
class NightWriter
  include Dictionary

  attr_reader :first_row,
              :second_row,
              :third_row,
              :braille

  def initialize
      @braille    = []
      @first_row  = ""
      @second_row = ""
      @third_row  = ""
  end

  def translate_letter(letter)
    dictionary[letter]
  end

  def translate_phrase(phrase)
    phrase_array = phrase.chars
    phrase_array.each do |char|
      if char.upcase == char && ("A".."Z").cover?(char)
        @braille << dictionary["%"]
        @braille << translate_letter(char.downcase)
      elsif
        @braille << translate_letter(char)
      end
    end
    @braille
  end

  def split_braille
    grab_first_two
    grab_second_two
    grab_third_two
  end

  def grab_first_two
    first_two = @braille.map do |string|
      string[0..1]
    end
    @first_row += first_two.join
  end

  def grab_second_two
    second_two = @braille.map do |string|
      string[2..3]
    end
    @second_row += second_two.join
  end

  def grab_third_two
    third_two = @braille.map do |string|
      string[4..5]
    end
    @third_row += third_two.join
  end

  def scan_rows
    scan_first_row
    scan_second_row
    scan_third_row
  end

  def scan_first_row
    @first_row = @first_row.scan(/.{1,160}/m)
  end

  def scan_second_row
    @second_row = @second_row.scan(/.{1,160}/m)
  end

  def scan_third_row
    @third_row = @third_row.scan(/.{1,160}/m)
  end

  def output(phrase)
    translate_phrase(phrase)
    split_braille
    scan_rows
    braille_string = ""
    count = 0
    @first_row.length.times do
    braille_string += "#{first_row[count]}\n#{second_row[count]}\n#{third_row[count]}\n"
    count += 1
    end
    braille_string
  end
end

# grab each line of 160 braille characters as strings and store each in a variable
# call .scan(/.{1,2}/m) on each line => this breaks up into an array of two character strings
# first_row.zip(second_row.zip(third_row)) => this takes all three rows and puts them back in order
# flatten this new nested zipped array => this will return a string back in order

# the line below is the first three rows of our song lyrics put back into original order (cap then l o v e   etc...)
# ".....00.0.0.0..00.0.0.000..0....0..............00.0.0.0..00.0.0.000..0....0..............00.0.0.0..00.0.0.000..0....000......00.0.0.0..00.0.0.000..0....0..............00.0.0.0..00.0.0.000..0....0..............00.0.0.0..00.0.0.000..0....000......00.0.0.0..00.0.0.000..0....0..............00.0.0.0..00.0.0.000..0....0..............00.0.0.0..00.0.0.000..0....0.00.....0.0000.0.00..0..0..0.000.0..0......0..00.0.......00.00.0..00..0000.0.00...00...00.00.0000......0000.0000..00.0...00"

# then use .scan(/.{1,6}/) again to cut this up into an array of 6 character strings
# convert back to english with the inverted dictionary


# def braille_to_eng(phrase)
#    inverted = @dictionary.invert
  #   phrase.chars.map do |char|
  #     inverted[char]
  #   end.join
  # end
