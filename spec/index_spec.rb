require_relative '../index.rb'

describe Enumerable do
  let(:num_arr) { [2, 6, 7, 8] }
  let(:str_arr) { %w[x c v] }
  let(:range) { (1..10) }
  let(:symbol_arr) { %i[foo bar] }

  describe '#my_each' do
    context 'array containing number' do
      it 'Print all the numbers' do
        expect { num_arr.my_each { |n| print n } }.to output('2678').to_stdout
      end
    end

    context 'array containing string' do
      it 'Print all the characters' do
        expect { str_arr.my_each { |n| print n, ' -- ' } }.to output('x -- c -- v -- ').to_stdout
      end
    end

    context 'if no block is given' do
      it 'return enumerator when no block is given' do
        expect(num_arr.my_each).to be_an Enumerator
      end
    end
  end

  describe '#my_each_with_index' do
    context 'array containing number' do
      it 'Print all the numbers with index less than 7' do
        expect do
          num_arr.my_each_with_index do |item, index|
            puts "index: #{index} for #{item}" if item < 7
          end
        end .to output("index: 0 for 2\nindex: 1 for 6\n").to_stdout
      end
    end

    context 'if no block is given' do
      it 'return enumerator when no block is given' do
        expect(num_arr.my_each_with_index).to be_an Enumerator
      end
    end
  end

  describe '#my_select' do
    context 'array containing number' do
      it 'Select odd numbers' do
        expect(num_arr.my_select(&:odd?)).to include(7)
      end
    end

    context 'for range' do
      it 'Select the multiples of three' do
        expect(range.my_select { |i| (i % 3).zero? }).to include(6)
      end
    end

    context 'for symbol' do
      it 'Select the foo symbol' do
        expect(symbol_arr.my_select { |x| x == :foo }).to eql([:foo])
      end
    end

    context 'if no block is given' do
      it 'return enumerator when no block is given' do
        expect(num_arr.my_select).to be_an Enumerator
      end
    end
  end

  describe '#my_all?' do
    context 'array containing number' do
      it 'Return true if all are numbers' do
        expect(num_arr.my_all?(Numeric)).to eql(true)
      end
    end

    context 'for array containing strings' do
      it 'Return true if all are strings' do
        expect(str_arr.my_all?(String)).to eql(true)
      end
    end

    context 'array containing number' do
      it 'Return false if all are not 5' do
        expect(num_arr.my_all?(5)).to eql(false)
      end
    end
  end
end
