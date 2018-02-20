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
      self.cursor.get_input
    end
  end

  def render
    system('clear')
    self.board.board.each do |k,v|
      if k == self.cursor.cursor_pos
        print "[".colorize(:blue)
        print v.to_s
        print "]".colorize(:blue)
      else
        print v.to_s + "  "
      end
      print "\n" if k[1]==7
    end
    true
  end
end
