# frozen_string_literal: true

require_relative('piece')

# Knight Piece
class Knight < Piece
  def initialize(color, pos)
    super
    @piece_type = (@color == :black ? "\u265E" : "\u2658")
    @movement = [8, 19, 21, 12, -8, -19, -21, -12]
  end

  private

  def search(board, direction)
    cur = direction + pos
    yield cur unless board[cur].nil? || (board[cur].is_a?(Piece) && board[cur].color == color)
  end
end
