
class NightReader
  attr_reader :first_row,
              :second_row,
              :third_row,
              :dictionary,
              :braille

  def initialize

  @dictionary = {
                  "a" => "0.....",
                  "b" => "0.0...",
                  "c" => "00....",
                  "d" => "00.0..",
                  "e" => "0..0..",
                  "f" => "000...",
                  "g" => "0000..",
                  "h" => "0.00..",
                  "i" => ".00...",
                  "j" => ".000..",
                  "k" => "0...0.",
                  "l" => "0.0.0.",
                  "m" => "00..0.",
                  "n" => "00.00.",
                  "o" => "0..00.",
                  "p" => "000.0.",
                  "q" => "00000.",
                  "r" => "0.000.",
                  "s" => ".00.0.",
                  "t" => ".0000.",
                  "u" => "0...00",
                  "v" => "0.0.00",
                  "w" => ".000.0",
                  "x" => "00..00",
                  "y" => "00.000",
                  "z" => "0..000",
                  " " => "......",
                  "." => "..00.0",
                  "," => "..0...",
                  "!" => "..000.",
                  "?" => "..0.00",
                  "’" => "....0.",
                  "-" => "....00",
                  "%" => ".....0"
                }
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
    inverted = @dictionary.invert
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
