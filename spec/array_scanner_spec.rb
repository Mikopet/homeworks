require 'array_scanner'

describe ArrayScanner do
  subject(:instantiated_array) { ArrayScanner.new(array) }
  let(:array) { [1, 2, 3, 5, 8, 13, 16, 17, 21, 24] }

  describe '#new' do
    context 'can be instantiated' do
      it 'with array of numbers' do
        expect { subject }.to_not raise_error
        expect(subject.array).to eq(array)
      end
    end
  end
end
