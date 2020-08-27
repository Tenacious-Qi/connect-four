# frozen_string_literal: true

# controls display of connect-four board and examines itself
# for 4 symbols in a line.
# allows players to "drop checkers" into itself.
class Board
  attr_accessor :round

  def initialize
    @cells = Array.new(6) { Array.new(7) { '-' } }
    @round = 1
  end

  def drop_checker(col, symbol)
    row = 5
    until @cells[row][col] == '-'
      return unless @cells[0][col] == '-'

      row -= 1
    end
    @cells[row][col] = symbol
  end

  def valid?(input)
    input.between?(1, 7) && @cells.any? { |n| n[input - 1] == '-' }
  end

  def connect_vertical?(col, symbol, count = 0)
    get_col_members(col).each do |member|
      member == symbol ? count += 1 : count = 0
      return true if count == 4
    end
    false
  end

  # helper method for #vertical_four?
  def get_col_members(col)
    col_members = []
    0.upto(5) { |row| col_members << @cells[row][col] }
    col_members
  end

  def connect_horizontal?(symbol)
    @cells.each do |row|
      count = 0
      row.each do |member|
        count += 1 if member == symbol
        count  = 0 if member != symbol
        return true if count == 4
      end
    end
    false
  end

  # loops over @cells, checking for a diagonal at each spot.
  def connect_diagonal?(symbol)
    row = 0
    until row > 5
      col = 0
      until col > 6
        return true if diagonal_four?(row, col, symbol)

        col += 1
      end
      row += 1
    end
    false
  end

  # helper method for connect_diagonal?
  # sets shift according to current position on board,
  # e.g. in top left quadrant of board,
  # diagonal always goes down and to the right (row and col both increase by 1).
  # so shift is [1, 1]
  def diagonal_four?(row, col, symbol)
    shift = []
    shift[0] =  1 if row.between?(0, 2)
    shift[0] = -1 if row.between?(3, 5)
    shift[1] =  1 if col.between?(0, 3)
    shift[1] = -1 if col.between?(3, 6)
    diagonal_symbols_equal?(row, col, symbol, shift)
  end

  # helper method for diagonal_four?
  # checks if all members of a given diagonal on the board are of the same type.
  def diagonal_symbols_equal?(row, col, symbol, shift)
    line = []
    0.upto(3) { |n| line << @cells[row + (shift[0] * n)][col + (shift[1] * n)] }
    line.all?(symbol)
  end

  def full?
    @cells.all? { |row| row.none?('-') }
  end

  def display
    puts "\nRound #{@round}: "
    @cells.each do |row|
      print "\n\t"
      row.each do |s|
        print " #{s} "
      end
    end
    puts "\n\n\t 1  2  3  4  5  6  7"
    puts
  end
end
