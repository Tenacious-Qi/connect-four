# frozen_string_literal: true
require 'colorize'

class Player
  attr_reader :symbol, :name
  attr_accessor :winner

  def initialize
    @name = ''
    @symbol = ''
    @winner = false
  end

  def get_name
    name = gets.chomp
    valid_name?(name) ? @name = name : get_name
  end

  CHOICES = [
    "\u2666".colorize(:yellow), "\u2665".colorize(:red), 
    "\u2660".colorize(:blue), "\u2663".colorize(:green)
    ]

  def get_symbol
    puts "#{@name}, please choose a checker type. "
    print "Your choices are: 1 [ #{CHOICES[0]} ], 2 [ #{CHOICES[1]} ], 3 [ #{CHOICES[2]} ], or 4 [ #{CHOICES[3]} ]: "
    choice = gets.chomp.to_i
    if valid_checker_selection?(choice)
      @symbol = CHOICES[choice - 1]
      puts "\n#{@name}'s checker is #{@symbol}"
    else
      get_symbol
    end
  end

  def valid_name?(input)
    input.match?(/\w/)
  end

  def valid_checker_selection?(input)
    input.between?(1, 4)
  end

  def assign_winner
    @winner = true
  end
end