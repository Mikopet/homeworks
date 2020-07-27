require '../src/v1/sensor_evaluator'

describe SensorEvaluator do
  subject(:initialized_class) { described_class.new(data) }

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

  describe '#collect' do
    subject(:collected_data) { initialized_class.send(:collect) }

    context 'called with bad log format' do
      let(:data) { "reference 70.0 45.0 6\nthermometer temp-1\n2007-04-05T22:00 72.4apple" }

      it 'raises Error' do
        expect {subject}.to raise_error(LoadError)
      end
    end

    context 'called with good log format by 1 sensor' do
      let(:data) { "reference 70.0 45.0 6\nthermometer temp-1\n2007-04-05T22:00 70\n2007-04-05T22:00 71.5" }

      it 'returns a Hash with the only sensor and its values' do
        expect(subject).to eq('temp-1': {type: :thermometer, values: [70.0, 71.5]} )
      end
    end

    context 'called with good log format by 2 other sensor' do
      let(:data) { "reference 70.0 45.0 6\nhumidity hum-1\n2007-04-05T22:04 45.2\n2007-04-05T22:05 45.3\nmonoxide mon-2\n2007-04-05T22:04 2\n2007-04-05T22:05 4" }

      it 'returns a Hash with the only sensor and its values' do
        expect(subject).to eq(
          'hum-1': { type: :humidity, values: [45.2, 45.3] },
          'mon-2': { type: :monoxide, values: [2.0, 4.0] }
        )
      end
    end
  end

  describe '#evaluate' do
    subject(:evaluated_data) { initialized_class.evaluate }

    context 'called with thermo sensor only' do
      let(:data) { <<~LOG }
reference 70.0 45.0 6
thermometer temp-1
2007-04-05T22:00 66
2007-04-05T22:01 74
thermometer temp-2
2007-04-05T22:01 69.5
2007-04-05T22:02 71.0
thermometer temp-3
2007-04-05T22:01 67
2007-04-05T22:02 73
thermometer temp-4
2007-04-05T22:01 71
2007-04-05T22:02 71
LOG

      it 'returns the evaluation Hash' do
        expect(subject).to eq(
          "temp-1": "precise",
          "temp-2": "ultra precise",
          "temp-3": "very precise",
          "temp-4": "precise"
        )
      end
    end

    context 'called without thermometer sensor' do
      let(:data) { <<~LOG }
reference 70.0 45.0 6
humidity hum-1
2007-04-05T22:04 45.2
2007-04-05T22:05 45.3
humidity hum-2
2007-04-05T22:04 44.4
2007-04-05T22:05 43.9
monoxide mon-1
2007-04-05T22:04 5
2007-04-05T22:05 7
monoxide mon-2
2007-04-05T22:04 2
2007-04-05T22:05 4
LOG

      it 'returns the evaluation Hash' do
        expect(subject).to eq(
          "hum-1": "keep",
          "hum-2": "discard",
          "mon-1": "keep",
          "mon-2": "discard"
        )
      end
    end

    # It's just for to be sure I don't mess anything mathematically
    context 'called with the sample data file' do
      let(:data) { File.read('data/sample_data.txt') }

      it 'returns the sample output given in task' do
        expect(subject).to eq(
          "temp-1": "precise",
          "temp-2": "ultra precise",
          "hum-1": "keep",
          "hum-2": "discard",
          "mon-1": "keep",
          "mon-2": "discard"
        )
      end
    end
  end
end
