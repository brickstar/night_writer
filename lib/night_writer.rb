class NightWriter
  attr_reader :dictionary
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
                    "cap" => ".....0"
                  }
    end

    def translate_letter(letter)
      @dictionary[letter]
    end

    def translate_phrase(phrase)
      phrase_array = phrase.chars
      converted = phrase_array.map do |char|
        translate_letter(char)
      end
      create_arrays(converted)
    end
    
    private
    def create_arrays(converted)
      converted.map do |string|
        string.split(",")
      end
    end
end
