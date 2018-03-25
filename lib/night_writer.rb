require 'pry'
class NightWriter
  attr_reader :dictionary,
              :first_row,
              :second_row,
              :third_row,
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
                    "'" => "....0.",
                    "-" => "....00",
                    "cap" => ".....0",
                    "\n" => "------"
                  }
      @alphabet   = ("A".."Z")
      @braille    = []
      @first_row  = []
      @second_row = []
      @third_row  = []
  end

  def translate_letter(letter)
    @dictionary[letter]
  end

  def translate_phrase(phrase)
    phrase_array = phrase.chars
    phrase_array.each do |char|
      if char.upcase == char && @alphabet.include?(char)
        @braille << @dictionary["cap"]
        @braille << translate_letter(char.downcase)
      elsif
        @braille << translate_letter(char)
      end
    end
    @braille
    binding.pry
  end

  def grab_first_two
    first_two = @braille.map do |string|
      string[0..1]
    end
    @first_row << first_two.join
  end

  def grab_second_two
    second_two = @braille.map do |string|
      string[2..3]
    end
    @second_row << second_two.join
  end

  def grab_third_two
    third_two = @braille.map do |string|
      string[4..5]
    end
    @third_row << third_two.join
  end

  def scan_first_row
    @first_row.join.scan(/.{1,160}/)
  end

  def scan_second_row
    @second_row.join.scan(/.{1,160}/)
  end

  def scan_third_row
    @third_row.join.scan(/.{1,160}/)
  end
end

nw = NightWriter.new
nw.translate_phrase("Love, Love, Love\n Love, Love, Love\n Love, Love, Love\n
                    There's nothing you can do that can't be done Nothing
                    you can sing that can't be sung Nothing you can say, but you
                    can learn how to play the game it's easy Nothing you can
                    make that can't be made No one you can save that can't be
                    saved Nothing you can do, but you can learn how to be you in
                    time It's easy All you need is love, all you need is love
                    All you need is love, love, love is all you needAll you need
                    is love All you need is love, love, love is all you need")
