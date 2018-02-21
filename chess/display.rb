require "colorize"
require_relative "cursor"


class Display
  attr_reader :board, :cursor
  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0],board)
  end

  def run
    while true
      render
      saved_input = self.cursor.get_input
      return saved_input if saved_input.is_a?(Array)
    end
  end

  def render
    system('clear')
    (0..7).to_a.each do |row_idx|
      (0..7).to_a.each do |col_idx|
        if (row_idx + col_idx)%2 == 0
          background = :white
        else
          background = :black
        end
        pos = [row_idx, col_idx]
        piece = board.board[pos]

        if pos == self.cursor.cursor_pos
          print "[".colorize(:color=> :green, :background=> background)
          print piece.to_s.colorize(:background=> background)
          print "]".colorize(:color=> :green, :background=> background)
        else
          print " ".colorize(:background => background) + piece.to_s.colorize(:background => background) + " ".colorize(:background => background)
        end
      end
      print "\n"
    end
    true
  end
end
