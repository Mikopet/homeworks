require '../src/v1/sensor_evaluator'

describe SensorEvaluator, '#evaluate' do
  subject(:evaluation) { described_class.new(data).evaluate }

  context 'call without data' do
    let(:data) { '' }

    it 'raises Error' do
      expect {subject}.to raise_error(LoadError)
    end
  end

  context 'call without reference values' do
    it 'raises Error' do
    end
  end

  context 'call without valid reference values' do
    it 'raises Error' do
    end
  end
end
