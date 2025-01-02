# frozen-string-literal: true

require_relative('piece')

# Knight Piece
class Knight < Piece
  def initialize(color)
    super(color)
    @piece_type = (@color == :black ? "\u265E" : "\u2658")
  end
end
