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

  # return true if the move is truly valid (king is not in check), false otherwise
  def valid_moves(chessboard, target)
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
