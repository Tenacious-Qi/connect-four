# frozen_string_literal: true

require 'colorize'

# handles player data pertinent to game, contains a boolean @winner attribute
class Player
  attr_reader :symbol, :name
  attr_accessor :winner

  def initialize
    @name = ''
    @symbol = ''
    @winner = false
  end

  def request_name
    name = gets.chomp
    loop do
      break if valid_name?(name)

      print 'please enter a valid name: '
      name = gets.chomp
    end
    @name = name
  end

  def request_symbol
    show_symbol_choices
    choice = gets.chomp.to_i
    loop do
      break if valid_checker?(choice)

      print 'please enter a number 1 thru 4: '
      choice = gets.chomp.to_i
    end
    assign_symbol(choice)
  end

  CHOICES = [
    "\u2666".colorize(:yellow), "\u2665".colorize(:red),
    "\u2660".colorize(:blue), "\u2663".colorize(:green)
  ].freeze

  def show_symbol_choices
    puts "#{@name}, please choose a checker type. "
    print 'Your choices are: ' \
    "#{CHOICES[0]} (1), #{CHOICES[1]} (2), " \
    "#{CHOICES[2]} (3), or #{CHOICES[3]} (4): "
  end

  def assign_symbol(choice)
    puts "\n#{@name}'s checker is #{CHOICES[choice - 1]}"
    @symbol = CHOICES[choice - 1]
  end

  def valid_name?(input)
    input.match?(/\w/)
  end

  def valid_checker?(input)
    input.between?(1, 4)
  end

  def assign_winner
    @winner = true
  end
end
