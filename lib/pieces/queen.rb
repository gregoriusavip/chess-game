# frozen-string-literal: true

require_relative('piece')

# Queen Piece
class Queen < Piece
  def initialize(color)
    super(color)
    @piece_type = (@color == :black ? "\u265B" : "\u2655")
  end
end
