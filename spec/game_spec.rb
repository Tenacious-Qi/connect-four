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
        allow(game).to receive(:check_for_winner)
        allow(board).to receive(:valid?).and_return(true)
      end
      it 'tells @board to mark selected column' do
        expect(board).to receive(:drop_checker).with(p1_col.to_i - 1, p1.symbol)
        game.p1_turn
      end
    end
  end

  describe '#check_for_winner' do

    before do
      allow(p1).to receive(:symbol).and_return('X')
      allow(board).to receive(:connect_vertical?)
      allow(board).to receive(:connect_diagonal?)
      allow(board).to receive(:connect_horizontal?)
    end

    context 'when there are 4 symbols of the same kind in a board row' do
      before do
        allow(board).to receive(:connect_horizontal?).with('X').and_return(true)
      end
      it 'tells player instance with that symbol to assign itself as the winner' do
        expect(p1).to receive(:assign_winner)
        game.check_for_winner('X')
      end
    end

    context 'when there are 4 symbols of the same kind in a board column' do

      winning_col = 2

      before do
        allow(board).to receive(:connect_vertical?).with(winning_col - 1, 'X').and_return(true)
      end
      it 'tells player instance with that symbol to assign itself as the winner' do
        expect(p1).to receive(:assign_winner)
        game.check_for_winner('X', winning_col)
      end
    end

    context 'when there are 4 symbols of the same kind in a board diagonal' do
      before do
        allow(board).to receive(:connect_diagonal?).with('X').and_return(:true)
      end
      it 'tells player instance with that symbol to assign itself as the winner' do
        expect(p1).to receive(:assign_winner)
        game.check_for_winner('X')
      end
    end
  end
end
