# frozen_string_literal: true

require 'colorize'
require_relative './game.rb'
require_relative './board.rb'
require_relative './player.rb'

game = Game.new(p1 = Player.new, p2 = Player.new, board = Board.new)
game.start_game
game.play_game

loop do
  if game.play_again
    game = Game.new(p1 = Player.new, p2 = Player.new, board = Board.new)
    game.start_game
  else
    exit
  end
  game.play_game
end
