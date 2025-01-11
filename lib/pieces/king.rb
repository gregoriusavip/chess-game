# frozen-string-literal: true

require_relative('piece')

# King Piece
class King < Piece
  attr_reader :movement

  def initialize(color, pos)
    super(color, pos)
    @piece_type = (@color == :black ? "\u265A" : "\u2654")
    @movement = [-1, 1, 9, -9, -11, 11, 10, -10]
  end
end
