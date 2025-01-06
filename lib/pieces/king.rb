# frozen-string-literal: true

require_relative('piece')

# King Piece
class King < Piece
  def initialize(color, pos)
    super(color, pos)
    @piece_type = (@color == :black ? "\u265A" : "\u2654")
  end
end
