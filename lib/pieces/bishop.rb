# frozen_string_literal: true

require_relative('piece')

# Bishop Piece
class Bishop < Piece
  def initialize(color, pos, moved: false)
    super
    @piece_type = (@color == :black ? "\u265D" : "\u2657")
    @movement = [9, -9, -11, 11]
  end
end
