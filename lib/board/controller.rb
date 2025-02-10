# frozen_string_literal: true

require_relative('../notation')

# Control the game's turn
module ChessController
  include Notation

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

    # TODO: ADD OTHER MOVE FUNCTION
    case move_type
    when :en_passant
      en_passant_move(piece, target)
    else
      standard_move(piece, target)
    end
    return unless piece.instance_of?(Pawn)

    pawn_moves(piece, current_pos, target)
  end

  private

  # --- Functions for each move types

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
  # TODO: ADD OTHER MOVE FUNCTION

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
