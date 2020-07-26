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

  describe '#evaluate' do
    subject(:evaluation) {construction.evaluate}
  end
end
