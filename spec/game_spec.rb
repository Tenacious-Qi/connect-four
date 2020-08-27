# frozen_string_literal: true

require './lib/game.rb'
require './lib/board.rb'
require './lib/player.rb'

describe Game do
  subject(:game) { described_class.new(player1, p2, board) }

  let(:player1)    { instance_double(Player) }
  let(:p2)    { instance_double(Player) }
  let(:board) { instance_double(Board) }

  before do
    allow(game).to receive(:puts)
    allow(game).to receive(:print)
  end

  describe '#start_game' do
    context 'when game is starting' do
      before do
        allow(player1).to receive(:request_info)
        allow(p2).to receive(:request_info)
        allow(game).to receive(:check_if_same_symbol)
      end
      it 'asks for player 1 info' do
        expect(player1).to receive(:request_info)
        game.start_game
      end
    end
  end

  describe '#player1_turn' do

    context 'after game has been started' do
      player1_col = '2'

      before do
        allow(game).to receive(:gets).and_return(player1_col)
        allow(player1).to receive(:name)
        allow(player1).to receive(:symbol)
        allow(game).to receive(:win?)
        allow(board).to receive(:valid?).and_return(true)
      end
      it 'tells @board to mark selected column' do
        expect(board).to receive(:drop_checker).with(player1_col.to_i - 1, player1.symbol)
        game.player1_turn
      end
    end

    context 'when player1 has four in a line' do
      before do
        input = '2'
        allow(player1).to receive(:name)
        allow(player1).to receive(:symbol)
        allow(game).to receive(:gets).and_return(input)
        allow(board).to receive(:valid?).with(input.to_i).and_return(true)
        allow(game).to receive(:win?).and_return(true)
        allow(board).to receive(:drop_checker).and_return('X')
      end

      it 'tells @player1 to assign itself the winner' do
        expect(player1).to receive(:assign_winner)
        game.player1_turn
      end
    end
  end
end
