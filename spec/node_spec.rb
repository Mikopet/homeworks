require 'node'

describe Node do
  subject(:node) { Node.new(hash) }

  describe '#new' do
    context 'can be instantiated' do
      let(:hash) { { id: 1, value: 1, parent_id: nil } }
      it 'with hash of symbols' do
        expect { subject }.to_not raise_error

        expect(subject.id).to eq(1)
        expect(subject.value).to eq(1)
        expect(subject.parent_id).to eq(nil)
      end
    end
    context 'can be instantiated' do
      let(:hash) { { 'id' => 1, 'value' => 1, 'parent_id' => 1 } }
      it 'with hash of strings' do
        expect { subject }.to_not raise_error

        expect(subject.id).to eq(1)
        expect(subject.value).to eq(1)
        expect(subject.parent_id).to eq(1)
      end
    end
  end
end
