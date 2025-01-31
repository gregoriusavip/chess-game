# frozen-string-literal: true

# handles converting from chess notation to board position and vice versa
module Notation
  def to_notation(pos)
    files = { 1 => 'a', 2 => 'b', 3 => 'c', 4 => 'd', 5 => 'e', 6 => 'f', 7 => 'g', 8 => 'h' }
    "#{files[(pos % 10)]}#{((110 - pos)) / 10}"
  end

  def to_position(notation)
    files = { 'a' => 1, 'b' => 2, 'c' => 3, 'd' => 4, 'e' => 5, 'f' => 6, 'g' => 7, 'h' => 8 }
    files[notation[0]] + (9 - notation[1].to_i) * 10 + 10
  end
end
