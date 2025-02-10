# frozen_string_literal: true

%w[piece pawn rook knight bishop king queen].each do |f_name|
  require_relative("../pieces/#{f_name}")
end
require_relative('display')
require_relative('check_pieces')
require_relative('controller')

# chessboard represented as a 10x12 board
class ChessBoard
  include ChessDisplay
  include ChessCheckPieces
  include ChessController

  attr_reader :board, :double_push_white, :double_push_black

  def initialize
    @board = Array.new(120, 0) # one dimensional 10x12 board
    set_nils
    @black_pieces = Set.new
    @white_pieces = Set.new
    init_board # TODO: should only run if its a new game and not a loaded game
  end

  def gen_move(color)
    color == :white ? create_white_move_list : create_black_move_list
  end

  private

  attr_accessor :white_pieces, :black_pieces

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
  def put_piece(color) # rubocop:disable Metrics/AbcSize
    offset = (color.eql?(:black) ? 21 : 91)
    pieces = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
    pieces.each_with_index do |piece, pos|
      @board[offset + pos] = piece.new(color, offset + pos)
      (color.eql?(:black) ? black_pieces : white_pieces).add(board[offset + pos])
      add_king(@board[offset + pos], color) if @board[offset + pos].instance_of?(King)
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

  def add_king(king, color)
    color == :black ? (@kblack = king) : (@kwhite = king)
  end

  protected

  attr_accessor :white_moves, :black_moves
  attr_writer :double_push_white, :double_push_black

  def add_piece(piece_type, color, target)
    @board[target] = piece_type.new(color, target, moved: true)
    (color == :white ? @white_pieces : @black_pieces).add(@board[target])
  end

  def remove_piece(piece)
    @white_pieces.delete(piece)
    @black_pieces.delete(piece)
  end

  def create_white_move_list
    @white_moves = Hash.new { |h, key| h[key] = {} }
    @white_pieces.each do |piece|
      piece.legal_moves(self) { |notation, type| white_moves[piece.pos][notation] = type }
    end
  end

  def create_black_move_list
    @black_moves = Hash.new { |h, key| h[key] = {} }
    @black_pieces.each do |piece|
      piece.legal_moves(self) { |notation, type| black_moves[piece.pos][notation] = type }
    end
  end
end
