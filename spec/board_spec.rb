require './lib/board.rb'

describe Board do
  subject(:board) { described_class.new }

  describe '#valid?' do
    context 'when a move is an available column' do
      it 'returns true' do
        move = 1
        expect(board.valid?(move)).to be true
      end
    end

    context 'when a move is not an available column' do 
      it 'returns false' do
        move = 8
        expect(board.valid?(move)).to be false
      end
    end

    context 'when column is full' do
      before do
        board.instance_variable_set(:@cells,

         [['X', nil, nil, nil, nil, nil, nil],
          ['X', nil, nil, nil, nil, nil, nil],
          ['X', nil, nil, nil, nil, nil, nil],
          ['X', nil, nil, nil, nil, nil, nil],
          ['X', nil, nil, nil, nil, nil, nil],
          ['X', nil, nil, nil, nil, nil, nil]]
        )
      end

      it 'returns false' do
        move = 1
        expect(board.valid?(move)).to be false
      end
    end

    context 'when column is partially filled' do
      before do
        board.instance_variable_set(:@cells,

          [[nil, nil, nil, nil, nil, nil, nil],
           [nil, nil, nil, nil, nil, nil, nil],
           [nil, nil, nil, nil, nil, nil, nil],
           [nil, nil, nil, nil, nil, nil, nil],
           ['X', nil, nil, nil, nil, nil, nil],
           ['X', nil, nil, nil, nil, nil, nil]]
         )
      end
      it 'returns true' do
        move = 1
        expect(board.valid?(move)).to be true
      end
    end

    context 'when only one spot in a column is open' do
      before do
        board.instance_variable_set(:@cells,

          [[nil, "X", "X", "X", "X", "X", "X"],
          ["X", "X", "X", "X", "X", "X", "X"],
          ["X", "X", "X", "X", "X", "X", "X"],
          ["X", "X", "X", "X", "X", "X", "X"],
          ["X", "X", "X", "X", "X", "X", "X"],
          ["X", "X", "X", "X", "X", "X", "X"]]
         )
      end
      context 'when user inputs the open column' do
        it 'returns true' do
          move = 1
          expect(board.valid?(move)).to be true
        end
      end

      context 'when user inputs a fully occupied column' do
        it 'returns false' do
          move = 5
          expect(board.valid?(move)).to be false
        end
      end
    end
  end

  describe '#drop_checker' do
    context 'when a column is selected on an empty board' do
      it 'drops checker to last spot in column' do
        column = 2
        symbol = 'X'
        board.drop_checker(column, symbol)
        expect(board.instance_variable_get(:@cells)).to eq(

          [[nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, 'X', nil, nil, nil, nil]]
        )
      end
    end
    context 'when a column is partially filled' do
      it 'marks the last available spot' do
        board.instance_variable_set(:@cells,

          [[nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, 'X', nil, nil, nil, nil]]
        )

        column = 2
        symbol_above = 'O'
        board.drop_checker(column, symbol_above)
        expect(board.instance_variable_get(:@cells)).to eq(

         [[nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, 'O', nil, nil, nil, nil],
          [nil, nil, 'X', nil, nil, nil, nil]]

        )
      end 
    end
  end

  describe '#vertical_four?' do
    context 'when there are four consecutive symbols of the same kind in a column' do
      before do
        board.instance_variable_set(:@cells, 
          
          [[nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, 'X', nil, nil, nil, nil],
          [nil, nil, 'X', nil, nil, nil, nil],
          [nil, nil, 'X', nil, nil, nil, nil],
          [nil, nil, 'X', nil, nil, nil, nil]]

        )
      end
      it 'returns true' do
        expect(board.vertical_four?('X')).to be true
      end
    end
  end
end


