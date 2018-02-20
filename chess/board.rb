class Board
  BOARD_SIZE = 8
  attr_reader :board

  def initialize
    @board = {}
    populate
  end

  def populate
    i = 0
    while i < BOARD_SIZE
      j = 0
      while j < BOARD_SIZE
        if i < 2 || i > 5
          self.board[[i,j]] = 1
        else
          self.board[[i,j]] = 0
        end
        j+=1
      end
      i+=1
    end
  end

  def move_piece(start_pos, end_pos)
    if self.board[start_pos] == nil || !valid_move?(start_pos, end_pos)
      raise ArgumentError
    end
    holder = self.board[start_pos]
    self.board[start_pos] = nil
    self.board[end_pos] = holder
  end

  def valid_move?(start_pos, end_pos)

  end
end
