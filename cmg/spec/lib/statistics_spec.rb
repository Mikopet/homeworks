require 'statistics'

describe 'Test Enumerable' do
  subject { [4, 6, 8] }

  context 'calling sum' do
    it 'returns sum of subject' do
      expect(subject.sum).to be(18)
    end
  end

  context 'calling mean' do
    it 'returns mean of subject in float' do
      expect(subject.mean).to eq(6)
      expect(subject.mean).to be_a(Float)
    end
  end

  context 'calling number' do
    it 'returns length of subject in float' do
      expect(subject.number).to eq(3)
      expect(subject.number).to be_a(Float)
    end
  end

  context 'calling sample_variance' do
    it 'returns variance of subject in float' do
      expect(subject.sample_variance).to eq(4)
      expect(subject.sample_variance).to be_a(Float)
    end
  end

  context 'calling standard_deviation' do
    it 'returns deviation of subject in float' do
      expect(subject.standard_deviation).to eq(2)
      expect(subject.standard_deviation).to be_a(Float)
    end
  end

  context 'calling range' do
    it 'returns range of subject' do
      expect(subject.range).to eq(4)
    end
  end
end
