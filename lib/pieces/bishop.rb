# frozen-string-literal: true

require_relative('piece')

# Bishop Piece
class Bishop < Piece
  def initialize(color)
    super(color)
    @piece_type = (@color == :black ? "\u265D" : "\u2657")
  end
end
