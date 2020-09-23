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

  describe '#maximal_odd_number' do
    subject(:max_odd) { instantiated_array.maximal_odd_number }

    context 'can get the maximum odd number' do
      let(:array) { [1, 2, 3] }
      it 'with valid array' do
        expect(subject).to eq(3)
      end
    end

    context 'can get 0' do
      let(:array) { [2, 4] }
      it ' without odd number' do
        expect(subject).to eq(0)
      end
    end
  end

  describe '#all_numbers_are_dividable_by_3' do
    subject(:dividable_by_3) { instantiated_array.all_numbers_are_dividable_by_3 }

    context 'it is true' do
      let(:array) { [3, 6] }
      it 'gives true' do
        expect(subject).to be(true)
      end
    end

    context 'it is false' do
      let(:array) { [3, 6, 10] }
      it 'gives false' do
        expect(subject).to be(false)
      end
    end
  end
end
