# frozen-string-literal: true

%w[piece pawn rook knight bishop king queen].each do |f_name|
  require_relative("../pieces/#{f_name}")
end
require_relative('display')
require_relative('controller')

# chessboard represented as a 10x12 board
class ChessBoard
  include ChessDisplay
  include ChessController

  def initialize
    @board = Array.new(120, 0) # one dimensional 10x12 board
    set_nils
    @black_pieces = Set.new
    @white_pieces = Set.new
    init_board
  end

  private

  attr_accessor :board, :white_pieces, :black_pieces

  def set_nils
    20.times do |i|
      @board[i] = nil
      @board[100 + i] = nil
    end
    (20..90).step(10) do |i|
      @board[i] = nil
      @board[9 + i] = nil
    end
  end

  # Set the pieces at the start of the game
  def init_board
    put_pawns
    put_piece(:black)
    put_piece(:white)
  end

  # Set rook, knight, bishop, queen, king
  def put_piece(color)
    offset = (color.eql?(:black) ? 21 : 91)
    pieces = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
    pieces.each_with_index do |piece, pos|
      @board[offset + pos] = piece.new(color, offset + pos)
      (color.eql?(:black) ? black_pieces : white_pieces).add(board[offset + pos])
    end
  end

  def put_pawns
    31.upto(38) do |pos| # black pawns
      @board[pos] = Pawn.new(:black, pos)
      black_pieces.add(board[pos])
    end
    81.upto(88) do |pos| # white pawns
      @board[pos] = Pawn.new(:white, pos)
      white_pieces.add(board[pos])
    end
  end
end

ChessBoard.new.debug_print
