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
    next_avail_index -= 1 while @cells[next_avail_index][column]
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
    0.upto(5) { |n| column_members << @cells[n][column] }
    column_members
  end

  
end
