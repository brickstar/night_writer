require_relative "dictionary"

# this is a NightReader class
class NightReader
  include Dictionary

  attr_reader :first_row,
              :second_row,
              :third_row,
              :braille

  def initialize
    @braille    = ""
    @first_row  = []
    @second_row = []
    @third_row  = []
  end

  def output(input)
    split_into_rows(input)
    scan_rows_to_length_of_eighty
    zip_rows
    convert_to_braille_strings
    braille_to_eng
    convert_capitals
    strip_capital_key.join
  end

  def split_into_rows(input)
    count = 1
    input.length.times do
      if count == 1
        @first_row << input.shift
        count = 2
      elsif count == 2
        @second_row << input.shift
        count = 3
      elsif count == 3
        @third_row << input.shift
        count = 1
      end
    end
  end

  def scan_rows_to_length_of_eighty
    scan_first_row
    scan_second_row
    scan_third_row
  end

  def scan_first_row
    delete_first_row_line_breaks
    @first_row = @first_row.scan(/.{1,2}/)
  end

  def scan_second_row
    delete_second_row_line_breaks
    @second_row = @second_row.scan(/.{1,2}/)
  end

  def scan_third_row
    delete_third_row_line_breaks
    @third_row = @third_row.scan(/.{1,2}/)
  end

  def delete_first_row_line_breaks
    @first_row = @first_row.join.delete("\n")
  end

  def delete_second_row_line_breaks
    @second_row = @second_row.join.delete("\n")
  end

  def delete_third_row_line_breaks
    @third_row = @third_row.join.delete("\n")
  end

  def zip_rows
    @braille = @first_row.zip(@second_row, @third_row).join
  end

  def convert_to_braille_strings
    @braille = @braille.scan(/.{1,6}/)
  end

  def translate_braille_letter(letter)
    inverted = dictionary.invert
    inverted[letter]
  end

  def braille_to_eng
    @braille = @braille.map do |char|
      translate_braille_letter(char)
    end
  end

  def convert_capitals
    english = @braille
    @braille.map.with_index do |char, index|
      if char == "%"
        english[index + 1] = english[index + 1].upcase
      end
    end
    english
  end

  def strip_capital_key
    english = convert_capitals
      english.map do |word|
      word.delete("%")
    end
  end
end
