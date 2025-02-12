# frozen_string_literal: true

require_relative('board/chessboard')
require_relative('prompt')

# A main menu for game of chess
class Chess < ChessBoard
  include Prompts

  def start_game
    loop do
      break if player_move(:white) == true || player_move(:black) == true
    end
  end

  private

  def player_move(color)
    print_board
    gen_move(color)
    return true if game_over?(color)

    res = turn(color)
    move(@board[res[0]], res[1], res[2])
  end

  def game_over?(color)
    moves = color == :white ? @white_moves : @black_moves
    return false unless moves.empty?

    print 'GAME OVER!!!'
    true
  end
end
