require '../src/v1/sensor_evaluator'

describe SensorEvaluator do
  subject(:construction) { described_class.new(data) }

  context 'call without data' do
    let(:data) { '' }

    it 'raises Error' do
      expect {subject}.to raise_error(LoadError)
    end
  end

  context 'call without valid reference values' do
    let(:data) { "reference 70.0 45.0 apple\nthermometer temp-1\n2007-04-05T22:00 72.4" }

    it 'raises Error' do
      expect {subject}.to raise_error(LoadError)
    end
  end

  context 'call with valid reference format' do
    let(:data) { "reference 70.0 45.0 6\nthermometer temp-1\n2007-04-05T22:00 72.4" }
    let(:parsed_references) { {thermometer: 70.0, humidity: 45.0, monoxide: 6.0} }

    it 'parses the values correctly' do
      expect(subject.instance_variable_get(:@reference)).to eq(parsed_references)
    end
  end

  describe '#evaluate' do
    subject(:evaluation) {construction.evaluate}

    context 'called with bad log format' do
      let(:data) { "reference 70.0 45.0 6\nthermometer temp-1\n2007-04-05T22:00 72.4apple" }

      it 'raises Error' do
        expect {subject}.to raise_error(LoadError)
      end
    end
  end
end
