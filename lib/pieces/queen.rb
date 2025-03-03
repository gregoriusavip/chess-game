# frozen_string_literal: true

require_relative('piece')

# Queen Piece
class Queen < Piece
  def initialize(color, pos, moved: false)
    super
    @piece_type = (@color == :black ? "\u265B" : "\u2655")
    @movement = [-1, 1, 9, -9, -11, 11, 10, -10]
  end
end
