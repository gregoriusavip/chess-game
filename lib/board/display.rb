# frozen-string-literal: true

# Handles displaying the current board
module ChessDisplay
  def debug_print
    @board.each_with_index do |square, index|
      print "#{square} "
      print "\n" if ((index + 1) % 10).zero?
    end
  end
end
