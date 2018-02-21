require_relative "pieces"

class Board
  BOARD_SIZE = 8
  attr_reader :board

  def initialize
    @board = {}
    populate
  end

  def populate
    self.board[[0,0]]= Rook.new(:black, self, [0,0])
    self.board[[0,1]] = Knight.new(:black, self, [0,1])
    self.board[[0,2]] = Bishop.new(:black, self, [0,2])
    self.board[[0,3]] = Queen.new(:black, self, [0,3])
    self.board[[0,4]] = King.new(:black, self, [0,4])
    self.board[[0,5]] = Bishop.new(:black, self, [0,5])
    self.board[[0,6]] = Knight.new(:black, self, [0,6])
    self.board[[0,7]] = Rook.new(:black, self, [0,7])

    (0..7).to_a.each do |col_idx|
      self.board[[1,col_idx]] = Pawn.new(:black, self, [1,col_idx])
      self.board[[2,col_idx]] = NullPiece.instance
      self.board[[3,col_idx]] = NullPiece.instance
      self.board[[4,col_idx]] = NullPiece.instance
      self.board[[5,col_idx]] = NullPiece.instance
      self.board[[6,col_idx]] = Pawn.new(:white, self, [1,col_idx])
    end

    self.board[[7,0]] = Rook.new(:white, self, [7,0])
    self.board[[7,1]] = Knight.new(:white, self, [7,1])
    self.board[[7,2]] = Bishop.new(:white, self, [7,2])
    self.board[[7,3]] = King.new(:white, self, [7,3])
    self.board[[7,4]] = Queen.new(:white, self, [7,4])
    self.board[[7,5]] = Bishop.new(:white, self, [7,5])
    self.board[[7,6]] = Knight.new(:white, self, [7,6])
    self.board[[7,7]] = Rook.new(:white, self, [7,7])

    self.board.values.each do |piece|
      piece.poss_moves
    end

  end

  def move_piece(start_pos, end_pos)

    piece = self.board[start_pos]
    # debugger
    if valid_move?(end_pos) && piece.moves.include?(end_pos) && !check_move?(start_pos,end_pos)
      piece.update_pos(end_pos)
    else
      puts "Not a valid move!"
    end
    # if self.board[start_pos] == nil || !valid_move?(start_pos, end_pos)
    #   raise ArgumentError
    # end
    # holder = self.board[start_pos]
    # self.board[start_pos] = nil
    # self.board[end_pos] = holder
  end

  def valid_move?(end_pos)
    end_pos.all? {|val| val.between?(0,7)}
  end

  def in_check?(color)
    the_king = self.board.values.select {|piece| piece.color == color && piece.is_a?(King)}
    opposing_pieces = self.board.values.select do |piece|
      piece.color != color && !piece.is_a(NullPiece)
    end
    opposing_moves = []
    opposing_pieces.each {|piece| opposing_moves<<piece.moves}
    opposing_moves.flatten!(1)
    check_bool = opposing_moves.include?(the_king.pos)
    checkmate?(the_king, opposing_moves) if check_bool
    check_bool
  end

  def checkmate?(king, opposing_moves)
    king.moves.all? {|move| opposing_moves.include?(move)}
  end

  def check_move?(start_pos, end_pos)
    mobile_piece = self.board[start_pos]
    end_piece = self.board[end_pos]
    mobile_piece.update_pos(end_pos)
    if in_check?(mobile_piece.color)
      puts "That puts your king in check!"
      mobile_piece.update_pos(start_pos)
      end_piece.update_pos(end_pos)
      return true
    end
    mobile_piece.update_pos(start_pos)
    end_piece.update_pos(end_pos)
    false
  end

end
