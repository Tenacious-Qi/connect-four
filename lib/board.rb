# frozen_string_literal: true

# controls display of connect-four board and examines itself
# for 4 symbols in a line.
# allows players to "drop checkers" into itself.
class Board
  def initialize
    @cells = Array.new(6) { Array.new(7) }
  end

  def valid?(input)
    input.between?(1, 7) && @cells.any? { |n| n[input - 1].nil? }
  end

  def drop_checker(column, symbol)
    if @cells.last[column]
      find_next_avail(column, symbol)
    else
      @cells.last[column] = symbol
    end
  end

  # helper method for #drop_checker
  def find_next_avail(column, symbol)
    next_avail_index = -1
    while @cells[next_avail_index][column] && next_avail_index > -6
      next_avail_index -= 1
    end
    @cells[next_avail_index][column] = symbol
  end

  def connect_vertical?(column, symbol, count = 0)
    get_column_members(column).each do |member|
      member == symbol ? count += 1 : count = 0
      return true if count == 4
    end
    false
  end

  # helper method for #vertical_four?
  def get_column_members(column)
    column_members = []
    0.upto(5) { |r| column_members << @cells[r][column] }
    column_members
  end

  def connect_horizontal?(symbol, count = 0)
    get_row_with_four(symbol).each do |member|
      member == symbol ? count += 1 : count = 0
      return true if count == 4
    end
    false
  end

  # helper method for #connect_horizontal?
  def get_row_with_four(symbol)
    row_with_four = []
    @cells.each do |r|
      row_with_four << r if r.count(symbol) == 4
    end
    row_with_four.flatten
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
    4.times { |n| line << @cells[row + (shift[0] * n)][col + (shift[1] * n)] }
    line.all?(symbol)
  end
end
