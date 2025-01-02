# frozen-string-literal: true

# Base class for any chess pieces
class Piece
  attr_reader :piece_type, :color

  def initialize(color)
    return unless (color == :white) || (color == :black)

    @color = color
  end

  protected

  attr_writer :piece_type, :color

  def to_s
    piece_type
  end
end
