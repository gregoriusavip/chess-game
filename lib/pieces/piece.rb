# frozen-string-literal: true

# Base class for any chess pieces
class Piece
  attr_reader :piece_type, :color, :pos

  def initialize(color, pos)
    return unless (color == :white) || (color == :black)

    @color = color
    @pos = pos
  end

  protected

  attr_writer :piece_type, :color, :pos

  def to_s
    piece_type
  end
end
