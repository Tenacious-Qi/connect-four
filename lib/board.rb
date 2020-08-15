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

  def drop_checker(col, symbol)
    if @cells.last[col]
      find_next_row(col, symbol)
    else
      @cells.last[col] = symbol
    end
  end

  # helper method for #drop_checker
  def find_next_row(col, symbol)
    row = 5
    while @cells[row][col] && row > 0
      return if @cells[0][col]

      row -= 1
    end
    @cells[row][col] = symbol
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
    0.upto(5) { |r| col_members << @cells[r][col] }
    col_members
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
    0.upto(3) { |n| line << @cells[row + (shift[0] * n)][col + (shift[1] * n)] }
    line.all?(symbol)
  end

  def display
    @cells.each do |r|
      print "#{r}\n"
    end
    nil
  end

  def display
    clear_terminal
    puts <<-HEREDOC
    Current Game:

      #{@cells[0]}   
      #{@cells[1]}   
      #{@cells[2]}
      #{@cells[3]}   
      #{@cells[4]}   
      #{@cells[5]}

    HEREDOC
  end
  
  def clear_terminal
    puts `clear`
  end
end
