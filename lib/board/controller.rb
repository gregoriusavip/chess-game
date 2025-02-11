# frozen_string_literal: true

require_relative('../notation')
require_relative('piece_movement')

# Control the game's turn
module ChessController
  include Notation
  include ChessPieceMovement

  def turn(color)
    moves = color == :white ? white_moves : black_moves
    loop do
      pos = piece_input(color)
      t_not = pos_input
      return [pos, t_not, moves[pos][t_not]] if moves.include?(pos) && moves[pos].include?(t_not)

      puts 'this move is not legal'
    end
  end

  def move(piece, t_not, move_type)
    piece.color == :black ? (@double_push_black = nil) : (@double_push_white = nil)
    current_pos = piece.pos
    target = to_position(t_not)

    case move_type
    when :en_passant
      en_passant_move(piece, target)
    when :king_side
      king_side_move(piece)
    when :queen_side
      queen_side_move(piece)
    else
      standard_move(piece, target)
    end
    return unless piece.instance_of?(Pawn)

    pawn_moves(piece, current_pos, target)
  end

  private

  def piece_input(color)
    loop do
      piece = @board[to_position(pos_input)]
      return piece.pos if piece.is_a?(Piece) && piece.color == color

      puts "target is not #{color}'s piece"
    end
  end

  def pos_input
    loop do
      input = gets.chomp.downcase
      return input if validate_pos(input)

      puts 'move format is not recognized'
    end
  end

  def validate_pos(input)
    return false if input.length != 2

    input[0].match?(/[a-h]/) && input[1].match?(/[1-8]/)
  end
end
