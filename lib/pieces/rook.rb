# frozen-string-literal: true

require_relative('piece')

# Rook Piece
class Rook < Piece
  def initialize(color, pos)
    super(color, pos)
    @piece_type = (@color == :black ? "\u265C" : "\u2656")
  end
end
