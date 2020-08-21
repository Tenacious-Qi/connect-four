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
    valid_name?(name) ? @name = name : request_name
  end

  CHOICES = [
    "\u2666".colorize(:yellow), "\u2665".colorize(:red),
    "\u2660".colorize(:blue), "\u2663".colorize(:green)
  ].freeze

  def request_symbol
    puts "#{@name}, please choose a checker type. "
    print "Your choices are " +
    "1 [ #{CHOICES[0]} ], 2 [ #{CHOICES[1]} ], " + 
    "3 [ #{CHOICES[2]} ], or 4 [ #{CHOICES[3]} ]: "
    choice = gets.chomp.to_i
    valid_checker?(choice) ? assign_symbol(choice) : request_symbol
  end

  def assign_symbol(choice)
    @symbol = CHOICES[choice - 1]
    puts "\n#{@name}'s checker is #{@symbol}"
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
