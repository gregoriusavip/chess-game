# frozen-string-literal: true

require_relative('pieces/piece')
require_relative('pieces/pawn')
require_relative('pieces/rook')
require_relative('pieces/knight')
require_relative('pieces/bishop')
require_relative('pieces/king')
require_relative('pieces/queen')

# chessboard represented as a 10x12 board
class ChessBoard
  attr_accessor :white_pieces, :black_pieces

  def initialize
    @board = Array.new(120, 0) # one dimensional 10x12 board
    # TODO: Assign squares outside of 8x8 playing field as nil
  end

  # given a color and position, return true or false if the square is in check by the opposite color
  def check_square(color, pos)
    yield_pieces(pos, [9, -9, 11, -11]) do |piece| # horizontal pieces
      return true if opponent_piece?(piece, color, [King, Queen, Bishop])
    end
    yield_pieces(pos, [10, -10, -1, 1]) do |piece| # linear pieces
      return true if opponent_piece?(piece, color, [King, Queen, Rook])
    end
    opponent_knight?(pos, color) || opponent_pawn?(pos, color)
  end

  private

  attr_accessor :board

  def init_board
    # TODO: put all of the pieces at the start of the round
  end

  def opponent_piece?(piece, color, piece_types)
    true if piece_types.include?(piece.class) && piece.color != color
  end

  def yield_pieces(pos, moves)
    moves.each do |move|
      cur_pos = pos + move
      cur_pos += move until @board[cur_pos].nil? || @board[cur_pos].is_a?(Piece)
      yield @board[cur_pos] unless @board[cur_pos].nil?
    end
  end

  def opponent_knight?(pos, color)
    moves = [8, 19, 21, 12, -8, -19, -21, -12]
    moves.each do |move|
      cur_pos = pos + move
      return true if opponent_piece?(@board[cur_pos], color, [Knight])
    end
  end

  def opponent_pawn?(pos, color)
    moves = (color == :black ? [-9, -11] : [9, 11])
    moves.each do |move|
      cur_pos = pos + move
      return true if opponent_piece?(@board[cur_pos], color, [Pawn])
    end
  end

  def debug_print
    @board.each_with_index do |square, index|
      print "#{square} "
      print "\n" if ((index + 1) % 8).zero?
    end
  end
end
