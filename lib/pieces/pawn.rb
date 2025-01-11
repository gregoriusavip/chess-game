# frozen-string-literal: true

require_relative('piece')

# Pawn Piece
class Pawn < Piece
  attr_reader :movement

  def initialize(color, pos)
    super(color, pos)
    @piece_type = (@color == :black ? "\u265F" : "\u2659")
    @movement = if color == :black
                  { mobility: 10, capture: [9, 11], en_passant: [19, 22] }
                else
                  { mobility: -10, capture: [-9, -11], en_passant: [-19, -22] }
                end
  end
end
