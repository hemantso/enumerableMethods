require_relative '../index.rb'

describe Enumerable do
  describe '#my_each' do
    let(:num_arr) {[2,6,7,8]}
    let(:str_arr) { %w[x c v] }

    context "array containing number" do
      it 'Print all the numbers' do
        expect { num_arr.my_each {|n| print n}}.to output('2678').to_stdout
      end
    end

    context "array containing string" do
      it 'Print all the characters' do
        expect { str_arr.my_each {|n| print n, ' -- '}}.to output("x -- c -- v -- ").to_stdout
      end
    end

    context "if no block is given" do
      it 'return enumerator when no block is given' do
        expect(num_arr.my_each).to be_an Enumerator
      end
    end

  end
end