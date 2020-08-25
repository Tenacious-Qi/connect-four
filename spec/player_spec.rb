# frozen_string_literal: true

require './lib/player.rb'
require './lib/game.rb'
require './lib/board.rb'

describe Player do
  subject(:player) { described_class.new }
  subject(:game) { Game.new(p1, p2, board) }

  describe '#request_name' do
    context "when the player's name is valid" do
      name = 'bob'
      before do
        allow(player).to receive(:gets).and_return(name)
      end
      it "returns the player's name" do
        expect(player.request_name).to eq(name)
      end
    end

    context "when the player's name is not valid" do
      invalid_name = ''
      before do
        allow(player).to receive(:gets).and_return(invalid_name)
        allow(player).to receive(:loop).and_yield
      end
      it 'requests a new name until it is valid' do
        expect { player.request_name }.to output(/please enter a valid name: /).to_stdout
      end
    end
  end

  describe 'request_symbol' do
    context 'when a selected symbol is valid' do
      choice = '1'
      # this symbol corresponds to player entering '1'
      symbol = "\u2666".colorize(:yellow)
      before do
        allow(player).to receive(:gets).and_return(choice)
        allow(player).to receive(:show_symbol_choices)
        allow(player).to receive(:puts)
      end

      it 'returns the player\'s selected symbol' do
        player.request_symbol
        expect(player.request_symbol).to eq(symbol)
      end
    end

    context 'when a player enters an invalid symbol selection' do
      choice = 'abc'
      before do
        allow(player).to receive(:gets).and_return(choice)
        allow(player).to receive(:loop).and_yield
      end
      it 'requests a new selection until it is valid' do
        expect { player.request_symbol }.to output(/please enter a number 1 thru 4: /).to_stdout
      end
    end
  end
end
