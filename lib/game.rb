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
    request_p1_info
    puts
    print 'Player 2, please enter your name: '
    request_p2_info
  end

  def request_p1_info
    @p1.request_name
    @p1.request_symbol
  end

  def request_p2_info
    @p2.request_name
    @p2.request_symbol
    check_if_same_symbol
  end

  def check_if_same_symbol
    while @p1.symbol == @p2.symbol
      puts "\n ** symbol taken, please select again **"
      @p2.request_symbol
    end
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
      p2_turn unless over?
      @board.display
    end
    declare_winner
    prompt_to_play_again
  end

  def p1_turn
    p1_col = request_p1_col
    loop do
      break if @board.valid?(p1_col)

      puts 'column unavailable. please select again...'
      p1_col = request_p1_col
    end
    @board.drop_checker(p1_col - 1, @p1.symbol)
    @p1.assign_winner if win?(@p1.symbol, p1_col)
  end

  def request_p1_col
    print "#{@p1.name}, choose a column to drop your checker into: "
    gets.chomp.to_i
  end

  def p2_turn
    @board.round += 1
    p2_col = request_p2_col
    loop do
      break if @board.valid?(p2_col)

      puts 'column unavailable. please select again...'
      p2_col = request_p2_col
    end
    @board.drop_checker(p2_col - 1, @p2.symbol)
    @p2.assign_winner if win?(@p2.symbol, p2_col)
  end

  def request_p2_col
    print "#{@p2.name}, choose a column to drop your checker into: "
    gets.chomp.to_i
  end

  def win?(symbol, col)
    @board.connect_horizontal?(@p1.symbol)  ||
      @board.connect_horizontal?(@p2.symbol)||
      @board.connect_diagonal?(symbol)      ||
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
  end

  def over?
    @p1.winner || @p2.winner || @board.full?
  end

  def tied?
    @board.full? && @p1.winner == false && @p2.winner == false
  end
end
