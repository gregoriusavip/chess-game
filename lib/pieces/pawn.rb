# frozen_string_literal: true

require_relative('piece')

# Pawn Piece
class Pawn < Piece
  attr_reader :movement

  def initialize(color, pos)
    super
    @piece_type = (@color == :black ? "\u265F" : "\u2659")
    @movement = if color == :black
                  { mobility: 10, capture: [9, 11] }
                else
                  { mobility: -10, capture: [-9, -11] }
                end
  end

  def legal_moves(chessboard)
    pushes(chessboard.board) { |target| yield to_notation(target), nil unless in_check?(chessboard, target) }
    captures(chessboard.board) { |target| yield to_notation(target), nil unless in_check?(chessboard, target) }
    en_passant(chessboard) do |target|
      yield to_notation(target), :en_passant unless in_check_ep?(chessboard, target)
    end
  end

  private

  # yields pseudo legal moves
  def captures(board)
    captures = movement[:capture]
    captures.each do |capture|
      target = pos + capture
      yield target if board[target].is_a?(Piece) && (board[target].color != color)
    end
  end

  # yields pseudo legal moves
  def pushes(board)
    push = movement[:mobility]
    target = pos + push
    yield target if board[target].eql?(0)
    yield target + push if !@moved && board[target + push].eql?(0)
  end

  # yields pseudo legal moves
  def en_passant(chessboard)
    target = (color == :black ? chessboard.double_push_white : chessboard.double_push_black)
    yield target if [(pos - 1), (pos + 1)].include?(target)
  end

  def in_check_ep?(chessboard, target)
    target_piece = temp_en_passant(chessboard, target)
    res = chessboard.check_king(color)
    remove_temp(chessboard, target, target_piece)
    res
  end

  def temp_en_passant(chessboard, target)
    chessboard.board[pos] = 0
    target_piece = chessboard.board[target]
    chessboard.board[target] = 0
    chessboard.board[target + @movement[:mobility]] = self
    target_piece
  end

  def remove_temp(chessboard, target, target_piece)
    chessboard.board[target + @movement[:mobility]] = 0
    chessboard.board[pos] = self
    chessboard.board[target] = target_piece
  end
end
