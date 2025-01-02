# frozen-string-literal: true

require_relative('pieces/pawn')
require_relative('pieces/rook')
require_relative('pieces/knight')
require_relative('pieces/bishop')
require_relative('pieces/king')
require_relative('pieces/queen')

# chessboard represented as a 8x8 board
class ChessBoard
  attr_accessor :white_pieces, :black_pieces

  def initialize
    @board = Array.new(64, 0) # one dimensional 8x8 board
  end

  private

  def init_board
    # TODO: put all of the pieces at the start of the round
  end

  def debug_print
    @board.each_with_index do |square, index|
      print "#{square} "
      print "\n" if ((index + 1) % 8).zero?
    end
  end
end
