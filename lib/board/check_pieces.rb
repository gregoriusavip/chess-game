# frozen_string_literal: true

# Contains information regarding pieces' check status
module ChessCheckPieces
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

  def check_king(color)
    pos = (color == :white ? @kwhite.pos : @kblack.pos)
    check_square(color, pos)
  end

  private

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
    false
  end

  def opponent_pawn?(pos, color)
    moves = (color == :white ? [-9, -11] : [9, 11])
    moves.each do |move|
      cur_pos = pos + move
      return true if opponent_piece?(@board[cur_pos], color, [Pawn])
    end
    false
  end
end
