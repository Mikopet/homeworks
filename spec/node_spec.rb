require 'node'

describe Node do
  let(:db) { DatabaseStub.new.nodes }

  describe '#new' do
    subject(:node) { described_class.new(hash) }
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

    context 'search a valid id' do
      let(:id) { 1 }
      let(:hash) { db.first }

      it 'gives back the node' do
        expect(subject).to eq(described_class.new(hash))
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

    context 'search a valid id' do
      let(:parent_id) { 1 }
      let(:nodes) { [described_class.new(db[1]), described_class.new(db[2])] }

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

  describe '#parent' do
    subject(:parent) { node.parent }

    context 'have a parent' do
      let(:node) { described_class.new(db.last)}

      it 'gives back the right parent' do
        expect(subject).to eq(described_class.new(db[5]))
      end
    end

    context 'have no parent' do
      let(:node) { described_class.new(db.first)}

      it 'gives back no parent' do
        expect(subject).to be_nil
      end
    end
  end

  describe '#children' do
    subject(:children) { node.children }

    context 'have children' do
      let(:node) { described_class.new(db.first)}

      it 'gives back the right children' do
        child_1 = described_class.new(db[1])
        child_2 = described_class.new(db[2])

        expect(subject).to eq([child_1, child_2])
      end
    end

    context 'have no children' do
      let(:node) { described_class.new(db.last)}

      it 'gives back no children' do
        expect(subject).to be_empty
      end
    end
  end

  describe '#descendants and #self_and_descendants' do
    subject(:descendants) { node.descendants }

    context 'have descendants' do
      let(:node) { described_class.new(db[2])}

      it 'gives back the right descendants' do
        descendant_1 = described_class.new(db[4])
        descendant_2 = described_class.new(db[5])
        descendant_3 = described_class.new(db.last)

        expect(subject).to eq([descendant_1, descendant_2, descendant_3])
      end

      it 'gives back with self too' do
        expect(node.self_and_descendants).to include(node)
      end
    end

    context 'have no descendants' do
      let(:node) { described_class.new(db.last)}

      it 'gives back no descendants' do
        expect(subject).to be_empty
      end
    end
  end

  describe '#ancestors and #self_and_ancestors' do
    subject(:ancestors) { node.ancestors }

    context 'have ancestors' do
      let(:node) { described_class.new(db[4]) }

      it 'gives back the right ancestors' do
        ancestor_1 = described_class.new(db.first)
        ancestor_2 = described_class.new(db[2])

        expect(subject).to eq([ancestor_1, ancestor_2])
      end

      it 'gives back with self too' do
        expect(node.self_and_ancestors).to include(node)
      end
    end

    context 'have no ancestors' do
      let(:node) { described_class.new(db.first)}

      it 'gives back no ancestors' do
        expect(subject).to be_empty
      end
    end
  end

  describe '#siblings and #self_and_siblings' do
    subject(:siblings) { node.siblings }

    context 'have siblings' do
      let(:node) { described_class.new(db[1]) }

      it 'gives back the right siblings' do
        expect(subject).to eq([described_class.new(db[2])])
      end

      it 'gives back with self too' do
        expect(node.self_and_siblings).to include(node)
      end
    end

    context 'have no siblings' do
      let(:node) { described_class.new(db.first)}

      it 'gives back no siblings' do
        expect(subject).to be_empty
      end
    end
  end
end
