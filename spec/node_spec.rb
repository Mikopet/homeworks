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

  describe '.find_by_id' do
    subject(:find_by_id) { described_class.find_by_id(id) }
    let(:db) { DatabaseStub.new.nodes }

    context 'search a valid id' do
      let(:id) { 1 }
      let(:hash) { db.first }

      it 'gives back the node' do
        expect(subject).to eq(Node.new(hash))
      end
    end

    context 'search an invalid id' do
      let(:id) { -1 }

      it 'gives back empty array' do
        expect(subject).to be_nil
      end
    end
  end

  describe '.find_all_by_parent_id' do
    subject(:find_by_id) { described_class.find_all_by_parent_id(parent_id) }
    let(:db) { DatabaseStub.new.nodes }

    context 'search a valid id' do
      let(:parent_id) { 1 }
      let(:nodes) { [Node.new(db[1]), Node.new(db[2])] }

      it 'gives back the node' do
        expect(subject).to eq(nodes)
      end
    end

    context 'search an invalid id' do
      let(:parent_id) { -1 }

      it 'gives back empty array' do
        expect(subject).to be_empty
      end
    end
  end
end
