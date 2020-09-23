require 'array_scanner'

describe ArrayScanner do
  subject(:instantiated_array) { ArrayScanner.new(array) }
  let(:array) { [1, 1, 2, 3, 5, 8, 11] }

  describe '#new' do
    context 'can be instantiated' do
      it 'with array of numbers' do
        expect { subject }.to_not raise_error
        expect(subject.array).to eq(array)
      end
    end
  end

  describe '#even_and_odd_numbers' do
    subject(:even_or_odd) { instantiated_array.even_and_odd_numbers }
    context 'can get' do
      it 'even numbers' do
        expect(subject[:paros]).to eq([2, 8])
      end

      it 'odd numbers' do
        expect(subject[:paratlan]).to eq([1, 1, 3, 5, 11])
      end
    end
  end
end
