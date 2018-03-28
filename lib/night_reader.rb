require_relative "dictionary"
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

  def scan_rows
    scan_first_row
    scan_second_row
    scan_third_row
  end

  def scan_first_row
    @first_row = @first_row.join.delete("\n")
    @first_row = @first_row.scan(/.{1,2}/m)
  end

  def scan_second_row
    @second_row = @second_row.join.delete("\n")
    @second_row = @second_row.scan(/.{1,2}/m)
  end

  def scan_third_row
    @third_row = @third_row.join.delete("\n")
    @third_row = @third_row.scan(/.{1,2}/m)
  end

  def zip_rows
    @braille = @first_row.zip(@second_row, @third_row).join
  end

  def convert_to_braille_strings
    @braille = @braille.scan(/.{1,6}/m)
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
    eng_output = english.map do |word|
      word.delete("%")
    end
    eng_output
  end

  def output(input)
    split_into_rows(input)
    scan_rows
    zip_rows
    convert_to_braille_strings
    braille_to_eng
    convert_capitals
    strip_capital_key.join
  end
end
