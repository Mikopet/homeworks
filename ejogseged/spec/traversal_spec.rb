require 'traversal'

describe Traversal do
  let(:tree) { {
    :value => 1, :children => [
      { :value => 2, :children => [
        { :value => 4, :children => [] }
      ]},
      { :value => 3, :children => [
        { :value => 5, :children => [] },
        { :value => 6, :children => [
          { :value => 7, :children => [] }
        ]}
      ]}
    ]}
  }

  describe '#pre_order_traversal' do
    subject(:traversal) { described_class.new.pre_order_traversal(tree) }
    let(:result) { [ 1, 2, 4, 3, 5, 6, 7 ] }

    it 'returns array with good order' do
      expect(subject).to eq(result)
    end
  end

  describe '#post_order_traversal' do
    subject(:traversal) { described_class.new.post_order_traversal(tree) }
    let(:result) { [ 4, 2, 5, 7, 6, 3, 1 ] }

    it 'returns array with good order' do
      expect(subject).to eq(result)
    end
  end
end
