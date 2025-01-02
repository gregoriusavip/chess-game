# frozen-string-literal: true

require_relative('piece')

# Pawn Piece
class Pawn < Piece
  def initialize(color)
    super(color)
    @piece_type = (@color == :black ? "\u265F" : "\u2659")
  end
end
