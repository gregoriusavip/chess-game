# frozen-string-literal: true

require_relative('piece')

# Rook Piece
class Rook < Piece
  def initialize(color)
    super(color)
    @piece_type = (@color == :black ? "\u265C" : "\u2656")
  end
end
