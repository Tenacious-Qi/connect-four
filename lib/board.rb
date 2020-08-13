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
    get_row_with_four(row, symbol).each do |member|
      member == symbol ? consec_count += 1 : consec_count = 0
      return true if consec_count == 4
    end
    false
  end

  # helper method for #horizontal_four?
  def get_row_with_four(row, symbol)
    row_with_four = []
    @cells.each do |r|
      row_with_four << r if r.count(symbol) == 4
    end
    row_with_four.flatten
  end

  def diagonal_four?(s)
    r = 0
    until r > 5
      c = 0
      until c > 6
        # top left
        if r.between?(0, 2) && c.between?(0, 3)
          return true if @cells[r][c] == s && @cells[r + 1][c + 1] == s && @cells[r + 2][c + 2] == s && @cells[r + 3][c + 3] == s
        # top right
        elsif r.between?(0, 2) && c.between?(3, 6)
          return true if @cells[r][c] == s && @cells[r + 1][c - 1] == s && @cells[r + 2][c - 2] == s && @cells[r + 3][c - 3] == s
        # bottom left
        elsif r.between?(3, 5) && c.between?(0, 3)
          return true if @cells[r][c] == s && @cells[r - 1][c + 1] == s && @cells[r - 2][c + 2] == s && @cells[r - 3][c + 3] == s
        # bottom right
        elsif r.between?(3, 5) && c.between?(3, 6)
          return true if @cells[r][c] == s && @cells[r - 1][c - 1] == s && @cells[r - 2][c - 2] == s && @cells[r - 3][c - 3] == s
        end
        c += 1
      end
      r += 1
    end
    false
  end
end
