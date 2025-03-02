# frozen_string_literal: true

require_relative('piece')

# Rook Piece
class Rook < Piece
  def initialize(color, pos, moved: false)
    super
    @piece_type = (@color == :black ? "\u265C" : "\u2656")
    @movement = [-1, 1, 10, -10]
  end
end
