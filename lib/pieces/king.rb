# frozen-string-literal: true

require_relative('piece')
require_relative('rook')

# King Piece
class King < Piece
  attr_reader :movement

  def initialize(color, pos)
    super(color, pos)
    @piece_type = (@color == :black ? "\u265A" : "\u2654")
    @movement = [-1, 1, 9, -9, -11, 11, 10, -10]
  end

  def legal_moves(chessboard)
    super(chessboard)
    return if chessboard.check_king(color)

    yield '', :king_side if king_castle(chessboard.board) && king_check?(chessboard)
    yield '', :queen_side if queen_castle(chessboard.board) && queen_check?(chessboard)
  end

  private

  def king_castle(board)
    return false if @moved

    cur = pos + 1
    cur += 1 while board[cur].eql? 0
    return true if board[cur].instance_of?(Rook) && board[cur].color == color && !board[cur].moved

    false
  end

  def queen_castle(board)
    return false if @moved

    cur = pos - 1
    cur -= 1 while board[cur].eql? 0
    return true if board[cur].instance_of?(Rook) && board[cur].color == color && !board[cur].moved

    false
  end

  def queen_check?(chessboard)
    cur = pos

    2.times do
      cur -= 1
      return false if chessboard.check_square(color, cur)
    end
    true
  end

  def king_check?(chessboard)
    cur = pos

    2.times do
      cur += 1
      return false if chessboard.check_square(color, cur)
    end
    true
  end
end
