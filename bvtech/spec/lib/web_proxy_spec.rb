RSpec.describe WebProxy do
  subject { described_class.new(proxy_url: described_class::DEFAULT_WEB_PROXY) }

  describe '#initialize' do
    context 'with no constructor params' do
      it 'raises error' do
        expect { described_class.new }.to raise_error(ArgumentError)
      end
    end

    context 'with default `proxy_url`' do
      it 'raises nothing' do
        expect { subject }.to_not raise_error
      end
    end
  end

  describe '#get_content' do
    let(:content) { subject.get_content(url) }

    context 'given URL is invalid' do
      let(:url) { 'not so good URL, \'"+!%/=()Ö' }

      xit 'raises error' do
        expect { content }.to raise_error
      end
    end

    context 'given URL is valid' do
      let(:url) { 'https://api.ipify.org?format=json' }

      xit 'returns the content of given URL through proxy' do
        expect(content.keys).to include?(:ip)
        expect { IPAddr.new(content[:ip]) }.to_not raise_error
      end
    end
  end
end

