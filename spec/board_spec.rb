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

         [["X", "-", "-", "-", "-", "-", "-"],
          ["X", "-", "-", "-", "-", "-", "-"],
          ["X", "-", "-", "-", "-", "-", "-"],
          ["X", "-", "-", "-", "-", "-", "-"],
          ["X", "-", "-", "-", "-", "-", "-"],
          ["X", "-", "-", "-", "-", "-", "-"]]
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

          [["-", "-", "-", "-", "-", "-", "-"],
          ["-", "-", "-", "-", "-", "-", "-"],
          ["-", "-", "-", "-", "-", "-", "-"],
          ["-", "-", "-", "-", "-", "-", "-"],
          ["X", "-", "-", "-", "-", "-", "-"],
          ["X", "-", "-", "-", "-", "-", "-"]]
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

          [['-', "X", "X", "X", "X", "X", "X"],
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

          [["-", "-", "-", "-", "-", "-", "-"],
          ["-", "-", "-", "-", "-", "-", "-"],
          ["-", "-", "-", "-", "-", "-", "-"],
          ["-", "-", "-", "-", "-", "-", "-"],
          ["-", "-", "-", "-", "-", "-", "-"],
          ["-", "-", "X", "-", "-", "-", "-"]]
        )
      end
    end
    context 'when a column is partially filled' do
      it 'marks the last available spot' do
        board.instance_variable_set(:@cells,

          [["-", "-", "-", "-", "-", "-", "-"],
          ["-", "-", "-", "-", "-", "-", "-"],
          ["-", "-", "-", "-", "-", "-", "-"],
          ["-", "-", "-", "-", "-", "-", "-"],
          ["-", "-", "-", "-", "-", "-", "-"],
          ["-", "-", "X", "-", "-", "-", "-"]]
        )

        column = 2
        symbol_above = 'O'
        board.drop_checker(column, symbol_above)
        expect(board.instance_variable_get(:@cells)).to eq(

          [["-", "-", "-", "-", "-", "-", "-"],
          ["-", "-", "-", "-", "-", "-", "-"],
          ["-", "-", "-", "-", "-", "-", "-"],
          ["-", "-", "-", "-", "-", "-", "-"],
          ["-", "-", "O", "-", "-", "-", "-"],
          ["-", "-", "X", "-", "-", "-", "-"]]

        )
      end 
    end
    context 'when a column is completely filled' do
      before do
        board.instance_variable_set(:@cells,

          [["-", "-","X", "-", "-", "-", "-"],
          ["-", "-", "X", "-", "-", "-", "-"],
          ["-", "-", "X", "-", "-", "-", "-"],
          ["-", "-", "X", "-", "-", "-", "-"],
          ["-", "-", "X", "-", "-", "-", "-"],
          ["-", "-", "X", "-", "-", "-", "-"]]
        )
      end
      it 'returns nil' do
        expect(board.drop_checker(2, 'X')).to be nil
      end
    end
  end

  describe '#connect_vertical?' do
    context 'when there are four consecutive symbols of the same kind in a column' do
      before do
        board.instance_variable_set(:@cells, 
          
          [["-", "-", "-", "-", "-", "-", "-"],
          ["-", "-", "X", "-", "-", "-", "-"],
          ["-", "-", "X", "-", "-", "-", "-"],
          ["-", "-", "X", "-", "-", "-", "-"],
          ["-", "-", "X", "-", "-", "-", "-"],
          ["-", "-", "O", "-", "-", "-", "-"]]

        )
      end
      it 'returns true' do
        expect(board.connect_vertical?(2, 'X')).to be true
      end
    end
    
    context 'when there are four non-consecutive symbols of the same kind in a column' do
      before do
        board.instance_variable_set(:@cells,
         [["-", "-", "X", "-", "-", "-", "-"],
          ["-", "-", "X", "-", "-", "-", "-"],
          ["-", "-", "O", "-", "-", "-", "-"],
          ["-", "-", "O", "-", "-", "-", "-"],
          ["-", "-", "X", "-", "-", "-", "-"],
          ["-", "-", "X", "-", "-", "-", "-"]]
        )
      end
      it 'returns false' do
        expect(board.connect_vertical?(2, 'X')).to be false
      end
    end

    context 'when board is empty' do
      it 'returns false' do
        expect(board.connect_vertical?(2, 'X')).to be false
      end
    end
  end

  describe '#connect_horizontal?' do
    context 'when there are 4 consecutive symbols of the same kind in a row' do
      before do
        board.instance_variable_set(:@cells,
         [["-", "-", "X", "-", "-", "-", "-"],
          ["-", "-", "X", "-", "-", "-", "-"],
          ["-", "-", "O", "-", "-", "-", "-"],
          ["-", "O", "O", "O", "O", "-", "-"],
          ["-", "-", "X", "-", "-", "-", "-"],
          ["-", "-", "X", "-", "-", "-", "-"]]
        )
      end
      it 'returns true' do
        expect(board.connect_horizontal?('O')).to be true
      end
    end

    context 'when there are 4 non-consecutive symbols of the same kind in a row' do
      before do
        board.instance_variable_set(:@cells,
          [["-", "-", "-", "-", "-", "-", "-"],
          ["-", "-", "-", "-", "-", "-", "-"],
          ["-", "-", "-", "-", "-", "-", "-"],
          ["-", "-", "-", "-", "-", "-", "-"],
          ["-", "-", "-", "-", "-", "-", "-"],
          ["-", "O", "O", "X", "O", "O", "-"]]
        )
      end
      it 'returns false' do
        expect(board.connect_horizontal?(2, 'O')).to be false
      end
    end

    context 'when board is empty' do
      it 'returns false' do
        expect(board.connect_horizontal?(2, 'O')).to be false
      end
    end
  end

  describe '#connect_diagonal?' do
    context 'when there are 4 consecutive symbols of the same kind in a diagonal' do
      before do
        board.instance_variable_set(:@cells,
         [["-", "-", "-", "-", "-", "-", "-"],
          ["-", "-", "-", "X", "-", "-", "-"],
          ["-", "-", "-", "O", "X", "-", "-"],
          ["-", "-", "-", "X", "X", "X", "-"],
          ["-", "-", "-", "O", "O", "X", "X"],
          ["-", "-", "-", "X", "X", "O", "O"]]
        )
      end
      it 'returns true' do
        expect(board.connect_diagonal?('X')).to be true
      end
    end

    context 'when there are NOT 4 consecutive symbols of the same kind in a diagonal' do
      before do
        board.instance_variable_set(:@cells,
          [["-", "-", "-", "-", "-", "-", "-"],
          ["-", "-", "-", "O", "-", "-", "-"],
          ["-", "-", "-", "O", "X", "-", "-"],
          ["-", "-", "-", "X", "X", "X", "-"],
          ["-", "-", "-", "O", "O", "X", "X"],
          ["-", "-", "-", "X", "X", "O", "O"]]
         )
      end
      it 'returns false' do
        expect(board.connect_diagonal?('X')).to be false
      end
    end

    context 'when there are 4 consecutive symbols of the same kind in the bottom right quadrant' do
      before do
        board.instance_variable_set(:@cells,
          [["-", "-", "-", "-", "-", "-", "-"],
          ["-", "-", "-", "-", "-", "-", "-"],
          ["-", "-", "-", "X", "-", "-", "-"],
          ["-", "-", "-", "X", "X", "-", "-"],
          ["-", "-", "-", "O", "O", "X", "-"],
          ["-", "-", "-", "X", "X", "O", "X"]]
         )
      end
      it 'returns true' do
        expect(board.connect_diagonal?('X')).to be true
      end
    end
  end
end


