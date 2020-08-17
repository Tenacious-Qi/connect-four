
class Player
  def initialize
    @name = get_name
    @symbol = get_symbol
    @winner = false
  end

  def get_name
    print 'please enter your name: '
    name = gets.chomp
    valid_name?(name) ? name : get_name
  end

  def get_symbol
    choices = ["\u2666", "\u2665", "\u2660", "\u2663"]
    puts "#{@name}, please choose your board checker: "
    puts "Your choices are: #{choices[0]}, #{choices[1]}, #{choices[2]}, #{choices[3]}"
    puts "please enter 1 [ \u2666 ], 2 [ \u2665 ], 3 [ \u2660 ], or 4 [ \u2663 ]"
    choice = gets.chomp.to_i
    valid_checker_selection?(choice) ? choices[choice - 1] : get_symbol
  end

  def valid_name?(input)
    input.match?(/\w/)
  end

  def valid_checker_selection?(input)
    input.between?(1, 4)
  end
end