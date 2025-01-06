# frozen-string-literal: true

require_relative('piece')

# Pawn Piece
class Pawn < Piece
  def initialize(color, pos)
    super(color, pos)
    @piece_type = (@color == :black ? "\u265F" : "\u2659")
  end
end
