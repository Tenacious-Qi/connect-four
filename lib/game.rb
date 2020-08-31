# frozen_string_literal: true

# controls logic of Connect-Four
class Game
  attr_accessor :play_again

  def initialize(player1 = Player.new, player2 = Player.new, board = Board.new)
    @board = board
    @player1 = player1
    @player2 = player2
    @play_again = false
  end

  def start_game
    show_welcome_message
    print 'Player 1, please enter your name: '
    @player1.request_info
    puts
    print 'Player 2, please enter your name: '
    @player2.request_info
    check_if_same_symbol
  end

  def play_game
    @board.display
    until over?
      player1_turn unless @player2.winner
      player2_turn unless @player1.winner
    end
    declare_winner
    prompt_to_play_again
  end

  def player1_turn
    player1_col = request_player1_col
    loop do
      break if @board.valid?(player1_col)

      puts 'column unavailable. please select again...'
      player1_col = request_player1_col
    end
    @board.drop_checker(player1_col - 1, @player1.symbol)
    @board.display
    @player1.assign_winner if win?(@player1.symbol, player1_col)
  end

  def player2_turn
    @board.increment_displayed_round
    player2_col = request_player2_col
    loop do
      break if @board.valid?(player2_col)

      puts 'column unavailable. please select again...'
      player2_col = request_player2_col
    end
    @board.drop_checker(player2_col - 1, @player2.symbol)
    @board.display
    @player2.assign_winner if win?(@player2.symbol, player2_col)
  end

  private

  def check_if_same_symbol
    while @player1.symbol == @player2.symbol
      puts "\n ** symbol taken, please select again **"
      @player2.request_symbol
    end
  end

  def request_player1_col
    print "#{@player1.name}, choose a column to drop your checker into: "
    gets.chomp.to_i
  end

  def request_player2_col
    print "#{@player2.name}, choose a column to drop your checker into: "
    gets.chomp.to_i
  end

  def win?(symbol, col)
    @board.connect_horizontal?(symbol)  ||
      @board.connect_diagonal?(symbol)  ||
      @board.connect_vertical?(col - 1, symbol)
  end

  def show_welcome_message
    puts <<-HEREDOC

    Welcome to #{'Connect'.colorize(:red)}-#{'Four'.colorize(:yellow)}!

    * Win the game by connecting four checkers in a row, column, or diagonal line.
    * Don't let your opponent sneak up on you!

    * Before game starts, players will enter names and choose a checker type.

    #{'Good luck!'.colorize(:green)}

    HEREDOC
  end

  def over?
    @player1.winner || @player2.winner || @board.full?
  end

  def tied?
    @board.full? && @player1.winner == false && @player2.winner == false
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

  def declare_winner
    puts "#{@player1.name} wins!"               if @player1.winner
    puts "#{@player2.name} wins!"               if @player2.winner
    puts 'game ended without a winner :-/' if tied?
  end
end
