#!/usr/bin/env ruby

class Game
  def initialize(width, height)
    @boardWidth = width;
    @boardHeight = height;
    @board = initializeBoard(width, height)
    @deltas = [-1, 0, 1]

    # initGlider
    # initBlock
    initTumbler
  end

  def initializeBoard(width, height)
    board = Array.new(width){Array.new(height)}
    fillBoard(board)

    return board
  end

  def fillBoard(board)
    board.each_with_index do |_, row_i|
      board[row_i].each_with_index do |_, col_i|
        board[row_i][col_i] = Square.new(row_i, col_i)
      end
    end
  end

  def initGlider
    @board[0][1].empty = false
    @board[1][2].empty = false
    @board[2][0].empty = false
    @board[2][1].empty = false
    @board[2][2].empty = false
  end

  def initBlock
    @board[0][0].empty = false
    @board[0][1].empty = false
    @board[1][0].empty = false
    @board[1][1].empty = false
  end

  def initTumbler
    @board[7][5].empty = false
    @board[8][5].empty = false
    @board[9][5].empty = false

    @board[4][6].empty = false
    @board[5][6].empty = false
    @board[9][6].empty = false

    @board[4][7].empty = false
    @board[5][7].empty = false
    @board[6][7].empty = false
    @board[7][7].empty = false
    @board[8][7].empty = false

    @board[4][9].empty = false
    @board[5][9].empty = false
    @board[6][9].empty = false
    @board[7][9].empty = false
    @board[8][9].empty = false

    @board[4][10].empty = false
    @board[5][10].empty = false
    @board[9][10].empty = false

    @board[7][11].empty = false
    @board[8][11].empty = false
    @board[9][11].empty = false

  end

  def run
    system "clear" or system "cls"
    printBoard
    100.times do
      sleep 0.10
      step
      printBoard
    end
  end

  def printBoard
    system "clear" or system "cls"
    @board.each do |row|
      row.each do |square|
        print square.empty ? '. ' : 'o '
      end
      puts
    end
    puts
    puts
  end

  def step
    newBoard = initializeBoard(@boardWidth, @boardHeight)

    @board.each_with_index do |_, row_i|
      @board[row_i].each_with_index do |_, col_i|
        square = @board[row_i][col_i]
        neighborCount = howManyNeighbors(square)

        if square.empty
          if neighborCount == 3
            newBoard[square.x][square.y].empty = false
          end
        else
          if neighborCount <= 1 || neighborCount >= 4
            newBoard[square.x][square.y].empty = true
          else
            newBoard[square.x][square.y].empty = false
          end
        end
      end
    end

    @board = newBoard
  end

  def howManyNeighbors(square)
    neighbors = 0

    @deltas.each do |xDelta|
      @deltas.each do |yDelta|
        next if square.x + xDelta < 0 || square.x + xDelta >= @boardWidth
        next if square.y + yDelta < 0 || square.y + yDelta >= @boardHeight
        next if xDelta == 0 and yDelta == 0
        neighbor = @board[square.x+xDelta][square.y+yDelta]
        neighbors += 1 unless neighbor.empty
      end
    end

    neighbors
  end
end

class Square
  attr_accessor :empty, :x, :y

  def initialize(x, y)
    @empty = true
    @x = x
    @y = y
  end
end

g = Game.new(20, 80)
g.run
