# frozen_string_literal: true

require_relative('../notation')

# Control the game's turn
module ChessController
  include Notation

  def turn(color)
    moves = color == :white ? white_moves : black_moves
    loop do
      pos = piece_input(color)
      target = pos_input
      return [pos, target] if moves.include?(pos) && moves[pos].include?(target)

      puts 'this move is not legal'
    end
  end

  def make_move(piece, target_not)
    @board[piece.pos] = 0
    target = to_position(target_not)
    target_piece = @board[target]
    @board[target] = piece
    piece.pos = target
    piece.moved = true
    remove_piece(target_piece)
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
