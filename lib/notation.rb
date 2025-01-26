# frozen-string-literal: true

# handles converting from chess notation to board position and vice versa
module Notation
  def to_notation(pos)
    files = { 1 => 'a', 2 => 'b', 3 => 'c', 4 => 'd', 5 => 'e', 6 => 'f', 7 => 'g', 8 => 'h' }
    [files[(pos % 10)], ((110 - pos)) / 10]
  end
end
