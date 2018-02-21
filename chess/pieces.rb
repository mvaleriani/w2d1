require 'singleton'

class Piece

  attr_reader :color, :board, :dirs, :moves, :type
  attr_accessor :pos

  def initialize(color,board,pos)
    @color = color
    @board = board
    @pos = pos
    @type = ' '
    @dirs = []
    @moves = []
  end

  def poss_moves
    []
  end

  def to_s
    self.type.colorize(self.color)
  end

  def empty?
    self.type == ' '
  end

  def update_pos(end_pos)
    self.board.board[self.pos] = NullPiece.instance
    self.board.board[end_pos] = self
    self.pos = end_pos
    self.moves = poss_moves
  end

end

module SlidingPiece
  def poss_moves
    self.dirs.each do |dir|
      new_pos = [self.pos[0] + dir[0], self.pos[1] + dir[1]]
      while self.board.valid_move?(new_pos) && self.board.board[new_pos].is_a?(NullPiece)
        self.moves.push(new_pos)
        new_pos = [new_pos[0] + dir[0], new_pos[1] + dir[1]]
      end
      p new_pos
      if self.board.valid_move?(new_pos) && self.board.board[new_pos].color != self.color
        self.moves.push(new_pos)
      end
    end
  end
end

module SteppingPiece
  def poss_moves
    self.dirs.each do |dir|
      new_pos = [self.pos[0] + dir[0], self.pos[1] + dir[1]]
      if self.board.valid_move?(new_pos)
        self.moves.push(new_pos)
      end
    end
  end
end

class Rook < Piece

  include SlidingPiece

  def initialize(color,board,pos)
    super(color, board, pos)
    @type = "R"
    @dirs = [[1,0],[0,1],[-1,0],[0,-1]]
    @moves = []
  end

end

class Queen < Piece

  include SlidingPiece

  def initialize(color,board,pos)
    super(color, board, pos)
    @type = "Q"
    @dirs = [[1,0],[0,1],[-1,0],[0,-1],[1,1],[1,-1],[-1,-1],[-1,1]]
    @moves = []
  end

end

class Bishop < Piece

  include SlidingPiece

  def initialize(color,board,pos)
    super(color, board, pos)
    @type = "B"
    @dirs = [[1,1],[1,-1],[-1,-1],[-1,1]]
    @moves = []
  end

end

class Pawn < Piece
  include SteppingPiece

  def initialize(color,board,pos)
    super(color, board, pos)
    @type = "P"
    @dirs = [[1,0]] if color == ':black'
    @dirs = [[-1,0]] if color == ':white'
    @moves = []
  end

  def poss_moves
    self.dirs.each do |dir|
      new_pos = [self.pos[0] + dir[0], self.pos[1] + dir[1]]
      if self.board.valid_move?(new_pos)
        self.moves.push(new_pos)
      end
    end

    if self.color == ':black'
      capture_dirs = [[1,1],[1,-1]]
      capture_dirs.each do |dir|
        new_pos = [self.pos[0] + dir[0], self.pos[1] + dir[1]]
        if self.board.valid_move?(new_pos) && self.board.board[new_pos].color == ':white'
          self.moves << new_pos
        end
      end
    elsif self.color == ':white'
      capture_dirs = [[-1,1],[-1,-1]]
      capture_dirs.each do |dir|
        new_pos = [self.pos[0] + dir[0], self.pos[1] + dir[1]]
        if self.board.valid_move?(new_pos) && self.board.board[new_pos].color == ':black'
          self.moves << new_pos
        end
      end
    end

  end
end

class Knight < Piece

  include SteppingPiece

  def initialize(color,board,pos)
    super(color, board, pos)
    @type = "N"
    @dirs = [[-2,-1],[-2,1],[-1,-2],[-1,2],[1,2],[1,-2],[2,-1],[2,1]]
    @moves = []
  end

end

class King < Piece

  include SteppingPiece

  def initialize(color,board,pos)
    super(color, board, pos)
    @type = "K"
    @dirs = [[-1,-1],[-1,0],[-1,1],[0,-1],[0,1],[1,-1],[1,0],[1,1]]
    @moves = []
  end

end

class NullPiece < Piece

  include Singleton

  def initialize
    @color = :grey
    @type = ' '
  end

end
