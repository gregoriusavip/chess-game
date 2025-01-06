# frozen-string-literal: true

require_relative('piece')

# Queen Piece
class Queen < Piece
  def initialize(color, pos)
    super(color, pos)
    @piece_type = (@color == :black ? "\u265B" : "\u2655")
  end
end
