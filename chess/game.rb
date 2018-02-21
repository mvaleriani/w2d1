require_relative 'board'
require_relative 'pieces'
require_relative 'display'
require_relative 'cursor'

require 'byebug'

class Game
  attr_reader :gameboard, :display

  def initialize
    @gameboard = Board.new
    @display = Display.new(self.gameboard)
    run
  end

  def run
    # debugger
    move_arr = []
    while true

      move_arr.push(self.display.run.dup)
      # debugger
      if move_arr.length == 2
        self.gameboard.move_piece(move_arr[0], move_arr[0])
        move_arr = []
      end

    end
  end



end
