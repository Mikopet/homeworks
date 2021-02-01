require 'parser'

describe Parser do
  context 'test REGEX_' do
    context 'REFERENCE with bad data' do
      let(:string) { 'reference 70.0 45.0 apple' }

      it 'returns nil' do
        expect(string.match(described_class::REGEX_REFERENCE)).to be_nil
      end
    end

    context 'SENSOR with bad data' do
      let(:string) { 'thermometre temp-1' }

      it 'returns nil' do
        expect(string.match(described_class::REGEX_SENSOR)).to be_nil
      end
    end

    context 'VALUE with bad data' do
      let(:string) { 'thermometre temp-1' }

      it 'returns nil' do
        expect(string.match(described_class::REGEX_VALUE)).to be_nil
      end
    end

    context 'REFERENCE with valid data' do
      let(:string) { 'reference 70.0 45.0 6' }

      it 'returns MatchData' do
        expect(string.match(described_class::REGEX_REFERENCE)).to be_a(MatchData)
      end
    end

    context 'SENSOR with valid data' do
      let(:string) { 'humidity hum-1' }

      it 'returns MatchData' do
        expect(string.match(described_class::REGEX_SENSOR)).to be_a(MatchData)
      end
    end

    context 'VALUE with valid data' do
      let(:string) { '2007-04-05T22:08 6' }

      it 'returns MatchData' do
        expect(string.match(described_class::REGEX_VALUE)).to be_a(MatchData)
      end
    end
  end
end
