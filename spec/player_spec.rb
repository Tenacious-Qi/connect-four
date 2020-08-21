require './lib/player.rb'
require './lib/game.rb'
require './lib/board.rb'


describe Player do

  subject(:player) { described_class.new }
  subject(:game) { Game.new }
  let(:p1) { game.instance_variable_get(:@p1) }
  
  describe '#request_name' do
    context 'when #request_name is called on @p1 from Game#request_p1_info' do

      name = "John Smith"
      yellow_diamond = "\u2666".colorize(:yellow)

      before do
        allow(p1).to receive(:gets).and_return(name)
        allow(p1).to receive(:request_symbol).and_return(yellow_diamond)
      end

      it 'assigns the Player instance a @name attribute' do
        game.request_p1_info
        expect(p1.name).to eq(name)
      end
    end
  end

  describe 'request_symbol' do
    context 'when #request_name is called on @p1 from Game#request_p1_info' do
      let(:p1) { game.instance_variable_get(:@p1) }
      
      choice = '1'
      symbol = "\u2666".colorize(:yellow)
      name = "John Smith"
      
      before do
        allow(p1).to receive(:gets).and_return(choice)
        allow(p1).to receive(:request_symbol).and_return(symbol)
      end

      it 'assigns the Player instance a @symbol attribute' do
        game.request_p1_info
        expect(p1.symbol).to eq(symbol)
      end
    end
  end
end