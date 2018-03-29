require_relative 'dictionary'
require 'pry'

# this is a NightWriter class
class NightWriter
  include Dictionary

  attr_reader :first_row,
              :second_row,
              :third_row,
              :braille,
              :braille_string

  def initialize
    @braille    = []
    @first_row  = ""
    @second_row = ""
    @third_row  = ""
    @braille_string = ""
  end

  def output(phrase)
    translate_phrase(phrase)
    split_braille
    scan_rows
    count = 0
    @first_row.length.times do
      @braille_string += "#{first_row[count]}\n#{second_row[count]}\n#{third_row[count]}\n"
      count += 1
    end
    @braille_string
  end

  def translate_letter(letter)
    dictionary[letter]
  end

  def translate_number(number)
    numbers[number]
  end

  def translate_phrase(phrase)
    phrase_array = phrase.chars
    phrase_array.each do |char|
      if char.upcase == char && ("A".."Z").cover?(char)
        @braille << dictionary["%"]
        @braille << translate_letter(char.downcase)
      else
        @braille << translate_letter(char)
      end
    end
    @braille
  end
  def braille_caps
    @braille << dictionary["%"]
    @braille << translate_letter(char.downcase)
  end

  def split_braille
    grab_first_two
    grab_second_two
    grab_third_two
  end

  def grab_first_two
    @first_row += @braille.map do |string|
      string[0..1]
    end.join
  end

  def grab_second_two
    @second_row += @braille.map do |string|
      string[2..3]
    end.join
  end

  def grab_third_two
    @third_row = @braille.map do |string|
      string[4..5]
    end.join
  end

  def scan_rows
    scan_first_row
    scan_second_row
    scan_third_row
  end

  def scan_first_row
    @first_row = @first_row.scan(/.{1,80}/)
  end

  def scan_second_row
    @second_row = @second_row.scan(/.{1,80}/)
  end

  def scan_third_row
    @third_row = @third_row.scan(/.{1,80}/)
  end
end
