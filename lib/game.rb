
class Game
  
  def initialize(p1 = Player.new, p2 = Player.new, board = Board.new)
    @board = board
    @p1 = p1
    @p2 = p2
  end

  def start_game
    show_welcome_message
    print "Player 1, please enter your name: "
    @p1.get_name
    @p1.get_symbol
    puts
    print "Player 2, please enter your name: "
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
    until over?
      p1_turn unless @p2.winner
      p2_turn unless over?
    end
  end

  def over?
    @p1.winner || @p2.winner || @board.full?
  end

  def p1_turn
    print "#{@p1.name}, choose a column to drop your checker into"
    p1_col = gets.chomp.to_i
    @board.drop_checker(p1_col - 1, @p1.symbol)
  end

  def p2_turn
    print "#{@p2.name}, choose a column to drop your checker into"
    p2_col = gets.chomp.to_i
    @board.drop_checker(p2_col - 1, @p2.symbol)
  end


end