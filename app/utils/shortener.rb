module Shortener
  extend self

  BASE_62 = (0..9).to_a.map(&:to_s) + ('a'..'z').to_a + ('A'..'Z').to_a

  def encode62(decimal)
    return '0' if decimal == 0

    result = []

    while decimal > 0
      result << BASE_62[decimal.modulo(62)]
      decimal /= 62
    end

    result.join.reverse
  end

  def decode62(encoded)
    chars = encoded.reverse.chars

    chars.each_with_index.inject(0) do |sum, (char, idx)|
      sum + BASE_62.index(char) * (62 ** idx)
    end
  end
end
