require './lib/game.rb'

describe Game do
  subject(:game) { described_class.new }

  describe '#p1_turn' do
    selected_column = '1'

    before do
      allow(game).to receive(:puts)
      allow(game.board).to receive(:display)
      allow(game).to receive(:gets).and_return(selected_column)
    end

    context 'when selected column is open and valid' do
      it 'tells @board to drop checker into that column' do
        expect(game.board).to receive(:drop_checker).with(selected_column, 'X')
        game.p1_turn
      end
    end
  end
end