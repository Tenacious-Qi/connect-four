# frozen_string_literal: true

require './lib/game.rb'
require './lib/board.rb'
require './lib/player.rb'

describe Game do
  subject(:game) { described_class.new(p1, p2, board) }

  let(:p1)    { instance_double(Player) }
  let(:p2)    { instance_double(Player) }
  let(:board) { instance_double(Board) }

  before do
    allow(game).to receive(:puts)
    allow(game).to receive(:print)
  end

  describe '#start_game' do
    context 'when game is starting' do
      before do
        allow(p1).to receive(:request_name)
        allow(p1).to receive(:request_symbol)
        allow(p2).to receive(:request_name)
        allow(p2).to receive(:request_symbol)
        allow(game).to receive(:check_if_same_symbol)
      end
      it 'tells @p1 to assign itself a name attribute' do
        expect(p1).to receive(:request_name)
        game.start_game
      end

      it 'tells @p1 to assign itself a symbol' do
        expect(p1).to receive(:request_symbol)
        game.start_game
      end
    end
  end

  describe '#p1_turn' do

    context 'after game has been started' do
      p1_col = '2'

      before do
        allow(game).to receive(:gets).and_return(p1_col)
        allow(p1).to receive(:name)
        allow(p1).to receive(:symbol)
        allow(game).to receive(:win?)
        allow(board).to receive(:valid?).and_return(true)
      end
      it 'tells @board to mark selected column' do
        expect(board).to receive(:drop_checker).with(p1_col.to_i - 1, p1.symbol)
        game.p1_turn
      end
    end

    context 'when p1 has four in a line' do
      before do
        input = '2'
        allow(p1).to receive(:name)
        allow(p1).to receive(:symbol)
        allow(game).to receive(:gets).and_return(input)
        allow(board).to receive(:valid?).with(input.to_i).and_return(true)
        allow(game).to receive(:win?).and_return(true)
        allow(board).to receive(:drop_checker).and_return('X')
      end

      it 'tells @p1 to assign itself the winner' do
        expect(p1).to receive(:assign_winner)
        game.p1_turn
      end
    end
  end
end
