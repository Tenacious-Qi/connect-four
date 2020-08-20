require './lib/player.rb'
require './lib/game.rb'
require './lib/board.rb'


describe Player do

  subject(:game) { Game.new }
  subject(:player) { described_class.new }
  
  describe '#get_name' do
    context 'when #get_name is called on @p1 from Game#get_p1_info' do

      name = 'Bob'

      before do
        allow(game).to receive(:print)
        allow(game).to receive(:puts)
        allow(player).to receive(:gets).and_return(name)
      end
      it 'assigns Player instance an @name attribute' do
        game.get_p1_info
        expect(game.instance_variable_get(:@name)).to eq(name)
        
      end
    end
  end
end