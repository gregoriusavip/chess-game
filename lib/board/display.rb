# frozen_string_literal: true

# Handles displaying the current board
module ChessDisplay
  def print_board # rubocop:disable Metrics/AbcSize
    print '   '
    8.times { |i| print "#{('a'.ord + i).chr} " }
    print "\n\n"
    8.times do |i|
      print "#{8 - i}  "
      @board[(21 + (i * 10))..(28 + (i * 10))].each do |square|
        print "#{square} "
      end
      print "\n"
    end
  end
end
