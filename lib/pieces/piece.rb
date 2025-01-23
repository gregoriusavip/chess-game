# frozen-string-literal: true

require_relative('../notation')

# Base class for any chess pieces
class Piece
  include Notation
  attr_reader :piece_type, :color, :pos, :moved

  def initialize(color, pos, moved: false)
    return unless (color == :white) || (color == :black)

    @moved = moved
    @color = color
    @pos = pos
  end

  protected

  attr_writer :piece_type, :color, :pos, :moved

  # return true if the move is truly valid (king is not in check), false otherwise
  def in_check?(chessboard, target)
    chessboard.board[pos] = 0
    target_piece = chessboard.board[target]
    chessboard.board[target] = self
    res = chessboard.check_king(color)
    chessboard.board[pos] = self
    chessboard.board[target] = target_piece
    res
  end

  def to_s
    piece_type
  end
end
