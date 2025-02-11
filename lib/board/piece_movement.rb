# frozen_string_literal: true

# methods for moving pieces to the board
module ChessPieceMovement
  protected

  def standard_move(piece, target)
    move_helper(piece, target)
    @board[target] = piece
    piece.pos = target
  end

  def en_passant_move(piece, target)
    offset = piece.color == :black ? 10 : -10
    move_helper(piece, target)
    @board[target] = 0
    @board[target + offset] = piece
    piece.pos = target + offset
  end

  def king_side_move(piece)
    if piece.color == :white
      swap(95, 97)
      swap(98, 96)
    elsif piece.color == :black
      swap(25, 27)
      swap(28, 26)
    end
  end

  def queen_side_move(piece)
    if piece.color == :white
      swap(95, 93)
      swap(91, 94)
    elsif piece.color == :black
      swap(25, 23)
      swap(21, 24)
    end
  end

  # helper function for most move type
  def move_helper(piece, target)
    @board[piece.pos] = 0
    target_piece = @board[target]
    piece.moved = true unless piece.moved
    remove_piece(target_piece)
  end

  def pawn_moves(piece, pos, target)
    return if promo(piece, target)

    double_push(piece, pos, target)
  end

  def double_push(piece, pos, target)
    return unless (target - pos).abs == 20

    piece.color == :black ? (@double_push_black = target) : (@double_push_white = target)
  end

  # TODO: HANDLE PROMO FUNCTION
  def promo(piece, target)
    return false unless [1, 8].include?((target - 110) / 10)

    print 'promo'
    true
  end
end
