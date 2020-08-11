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

  def vertical_four?(symbol)
    @cells[2][2] == symbol && @cells[3][2] == symbol && @cells[4][2] == symbol && @cells[5][2] == symbol
  end
end