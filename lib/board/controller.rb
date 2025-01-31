# frozen_string_literal: true

require_relative('chessboard')

# Control the game's turn
class ChessController < ChessBoard
  def turn(color)
    color == :white ? create_white_move_list : create_black_move_list
  end

  protected

  attr_accessor :white_moves, :black_moves

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
