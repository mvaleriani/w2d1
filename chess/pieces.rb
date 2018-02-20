class Piece

  attr_reader :color, :board
  attr_accessor :pos

  def initialize(color,board,pos)
    @color = color
    @board = board
    @pos = pos
    @type = ' '
  end

  def to_s
    self.type
  end

  def empty?
    self.type == ' '
  end

end

class Rook < Piece

  include SlidingPiece

  def initialize(color,board,pos)
    super(color, board, pos)
    @type = "R"
    @dirs = [[1,0],[0,1],[-1,0],[0,-1]]
    @moves = poss_moves
  end

end

class Queen < Piece

  include SlidingPiece

  def initialize(color,board,pos)
    super(color, board, pos)
    @type = "Q"
    @dirs = [[1,0],[0,1],[-1,0],[0,-1],[1,1],[1,-1],[-1,-1],[-1,1]]
    @moves = poss_moves
  end

end

class Bishop < Piece

  include SlidingPiece

  def initialize(color,board,pos)
    super(color, board, pos)
    @type = "B"
    @dirs = [[1,1],[1,-1],[-1,-1],[-1,1]]
    @moves = poss_moves
  end

end

class Pawn < Piece

  def initialize(color,board,pos)
    super(color, board, pos)
    @type = "P"
  end

end

class Knight < Piece

  def initialize(color,board,pos)
    super(color, board, pos)
    @type = "N"
  end

end

class King < Piece

  def initialize(color,board,pos)
    super(color, board, pos)
    @type = "K"
  end

end

class NullPiece < Piece

  def initialize(color,board,pos)
    super(color, board, pos)

  end

end

module SlidingPiece
  def poss_moves
    moves = []
    self.directions.each do |dir|
      new_pos = [self.pos[0] + dir[0], self.pos[1] + dir[1]]
      while self.board.board[new_pos].is_a?(NullPiece)
        moves.push(new_pos)
        new_pos = [new_pos[0] + dir[0], new_pos[1] + dir[1]]
      end
      moves.push(new_pos)
    end
    moves
  end
end

module SteppingPiece

end
