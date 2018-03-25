require_relative 'dictionary'
require 'pry'

# this is a NightWriter class
class NightWriter
  include Dictionary
  attr_reader :dictionary,
              :first_row,
              :second_row,
              :third_row,
              :braille,
              :filename

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
                    "'" => "....0.",
                    "-" => "....00",
                    "cap" => ".....0",
                    "\n" => "------"
                  }
      @braille    = []
      @first_row  = ""
      @second_row = ""
      @third_row  = ""
      @hash       = {}
      @filename   = ""
  end

  def translate_letter(letter)
    @dictionary[letter]
  end

  def translate_phrase(phrase)
    phrase_array = phrase.chars
    phrase_array.each do |char|
      if char.upcase == char && ("A".."Z").cover?(char)
        @braille << @dictionary["cap"]
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



  def read_file
    input_file = File.open("message.txt", "r")
    @filename = input_file.sysread

  end
end
