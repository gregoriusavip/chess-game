# frozen_string_literal: true

require_relative '../../lib/board/chessboard'
require_relative '../../lib/pieces/pawn'

describe ChessBoard do
  subject(:chessboard) { described_class.new }

  describe 'check_square' do
    context 'when a black pawn diagonally in front of a square' do
      pos = 44
      before do
        chessboard.board[pos] = Pawn.new(:black, pos)
      end

      it 'returns true for white for pos + 11' do
        expect(chessboard.check_square(:white, pos + 11)).to be(true)
      end

      it 'returns true for white for pos + 9' do
        expect(chessboard.check_square(:white, pos + 9)).to be(true)
      end

      it 'returns false for black for pos + 9' do
        expect(chessboard.check_square(:black, pos + 9)).to be(false)
      end

      it 'returns false for black' do
        expect(chessboard.check_square(:black, pos + 11)).to be(false)
      end
    end

    context 'when a white pawn diagonally in front of a square' do
      pos = 84
      before do
        chessboard.board[pos] = Pawn.new(:white, pos)
      end

      it 'returns true for black for pos - 9' do
        expect(chessboard.check_square(:black, pos - 9)).to be(true)
      end

      it 'returns true for black for pos - 11' do
        expect(chessboard.check_square(:black, pos - 11)).to be(true)
      end

      it 'returns false for white for pos - 9' do
        expect(chessboard.check_square(:white, pos - 9)).to be(false)
      end

      it 'returns false for white for pos - 11' do
        expect(chessboard.check_square(:white, pos - 11)).to be(false)
      end
    end
  end
end
