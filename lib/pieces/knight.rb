# frozen-string-literal: true

require_relative('piece')

# Knight Piece
class Knight < Piece
  def initialize(color, pos)
    super(color, pos)
    @piece_type = (@color == :black ? "\u265E" : "\u2658")
    @movement = [8, 19, 21, 12, -8, -19, -21, -12]
  end
end
