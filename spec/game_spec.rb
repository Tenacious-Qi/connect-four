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
        allow(p1).to receive(:get_name)
        allow(p1).to receive(:get_symbol)
        allow(p2).to receive(:get_name)
        allow(p2).to receive(:get_symbol)
      end
      it 'tells @p1 to assign itself a name attribute' do
        expect(p1).to receive(:get_name)
        game.start_game
      end

      it 'tells @p1 to assign itself a symbol' do
        expect(p1).to receive(:get_symbol)
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
      end
      it 'tells @board to mark selected column' do
        expect(board).to receive(:drop_checker).with(p1_col.to_i - 1, p1.symbol)
        game.p1_turn
      end
    end
  end

  describe '#assign_winner' do
    
  end

end