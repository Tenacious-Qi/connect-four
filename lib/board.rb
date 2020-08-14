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

  def vertical_four?(column, symbol, consec_count = 0)
    get_column_members(column).each do |member|
      member == symbol ? consec_count += 1 : consec_count = 0
      return true if consec_count == 4
    end
    false
  end

  # helper method for #vertical_four?
  def get_column_members(column)
    column_members = []
    0.upto(5) { |r| column_members << @cells[r][column] }
    column_members
  end

  def horizontal_four?(row, symbol, consec_count = 0)
    get_row_with_four(symbol).each do |member|
      member == symbol ? consec_count += 1 : consec_count = 0
      return true if consec_count == 4
    end
    false
  end

  # helper method for #horizontal_four?
  def get_row_with_four(symbol)
    row_with_four = []
    @cells.each do |r|
      row_with_four << r if r.count(symbol) == 4
    end
    row_with_four.flatten
  end

  def diagonal_four?(sym)
    row = 0
    until row > 5
      col = 0
      until col > 6
        return true if line_found?(row, col, sym)

        col += 1
      end
      row += 1
    end
    false
  end

  # helper method for diagonal_four?
  def line_found?(row, col, sym)
    # top left: row and col increase
    if row.between?(0, 2) && col.between?(0, 3)
      @cells[row][col] == sym && @cells[row + 1][col + 1] == sym && @cells[row + 2][col + 2] == sym && @cells[row + 3][col + 3] == sym
    # top right: row increases, col decreases
    elsif row.between?(0, 2) && col.between?(3, 6)
      @cells[row][col] == sym && @cells[row + 1][col - 1] == sym && @cells[row + 2][col - 2] == sym && @cells[row + 3][col - 3] == sym
    # bottom left: row decreases, col increases
    elsif row.between?(3, 5) && col.between?(0, 3)
      @cells[row][col] == sym && @cells[row - 1][col + 1] == sym && @cells[row - 2][col + 2] == sym && @cells[row - 3][col + 3] == sym
    # bottom right: row and col decrease
    elsif row.between?(3, 5) && col.between?(3, 6)
      @cells[row][col] == sym && @cells[row - 1][col - 1] == sym && @cells[row - 2][col - 2] == sym && @cells[row - 3][col - 3] == sym
    end
  end
end
