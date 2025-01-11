# frozen-string-literal: true

# Base class for any chess pieces
class Piece
  attr_reader :piece_type, :color, :pos, :moved

  def initialize(color, pos, moved: false)
    return unless (color == :white) || (color == :black)

    @moved = moved
    @color = color
    @pos = pos
  end

  protected

  attr_writer :piece_type, :color, :pos, :moved

  def to_s
    piece_type
  end
end
