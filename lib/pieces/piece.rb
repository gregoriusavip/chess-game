# frozen_string_literal: true

require_relative('../notation')

# Base class for any chess pieces
class Piece
  include Notation
  attr_reader :piece_type, :color
  attr_accessor :pos, :moved

  def initialize(color, pos, moved: false)
    return unless (color == :white) || (color == :black)

    @moved = moved
    @color = color
    @pos = pos
  end

  def legal_moves(chessboard)
    @movement.each do |move|
      search(chessboard.board, move) { |target| yield to_notation(target), nil unless in_check?(chessboard, target) }
    end
  end

  protected

  attr_writer :piece_type, :color

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

  def search(board, direction)
    cur = direction + pos
    until board[cur].nil? || (board[cur].is_a?(Piece) && board[cur].color == color)
      yield cur
      return if board[cur].is_a?(Piece)

      cur += direction
    end
  end

  def to_s
    piece_type
  end
end
