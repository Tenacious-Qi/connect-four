# frozen_string_literal: true

# controls logic of Connect-Four
class Game
  attr_accessor :play_again

  def initialize(p1 = Player.new, p2 = Player.new, board = Board.new)
    @board = board
    @p1 = p1
    @p2 = p2
    @play_again = false
  end

  def start_game
    show_welcome_message
    print 'Player 1, please enter your name: '
    get_p1_info
    puts
    print 'Player 2, please enter your name: '
    get_p2_info
  end

  def get_p1_info
    @p1.get_name
    @p1.get_symbol
  end

  def get_p2_info
    @p2.get_name
    @p2.get_symbol
  end

  def show_welcome_message
    puts <<-HEREDOC

    Welcome to Connect Four!

    Win the game by connecting four checkers in a row, column, or diagonal line.
    Don't let your opponent sneak up on you!

    Before game starts, players will enter names and choose a checker type.

    Good luck!

    HEREDOC
  end

  def play_game
    @board.display
    until over?
      p1_turn unless @p2.winner
      @board.display
      p2_turn unless @p1.winner
      @board.display
    end
    declare_winner
    prompt_to_play_again
  end

  def p1_turn
    print "#{@p1.name}, choose a column to drop your checker into: "
    p1_col = gets.chomp.to_i
    if @board.column_full?(p1_col - 1)
      puts 'column full. please select again...'
      p1_turn
    end
    @board.drop_checker(p1_col - 1, @p1.symbol)
    check_for_winner(@p1.symbol, p1_col)
  end

  def p2_turn
    print "#{@p2.name}, choose a column to drop your checker into: "
    p2_col = gets.chomp.to_i
    if @board.column_full?(p2_col - 1)
      puts 'column full. please select again...'
      p2_turn
    end
    @board.drop_checker(p2_col - 1, @p2.symbol)
    check_for_winner(@p2.symbol, p2_col)
  end

  def check_for_winner(symbol, col = 0)
    if symbol == @p1.symbol
      @p1.assign_winner if win?(symbol, col)
    else
      @p2.assign_winner if win?(symbol, col)
    end
  end

  def win?(symbol, col)
    @board.connect_horizontal?(symbol)    ||
      @board.connect_diagonal?(symbol)    ||
      @board.connect_vertical?(col - 1, symbol)
  end

  def declare_winner
    puts "#{@p1.name} wins!"               if @p1.winner
    puts "#{@p2.name} wins!"               if @p2.winner
    puts 'game ended without a winner :-/' if tied?
  end

  def prompt_to_play_again
    print "\nWould you like to play again? Enter Y or N: "
    answer = gets.chomp.upcase
    until answer.match?(/[YN]/)
      puts 'please enter Y or N:'
      answer = gets.chomp.upcase
    end
    @play_again = true if answer.match?(/[Y]/)
    @play_again = false if answer.match?(/[N]/)
  end

  def over?
    @p1.winner || @p2.winner || @board.full?
  end

  def tied?
    @board.full? && @p1.winner == false && @p2.winner == false
  end
end
