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

      it 'raises error' do
        expect { content }.to raise_error(URI::InvalidURIError)
      end
    end

    context 'given URL is valid' do
      let(:url) { 'api.ipify.org?format=json' }

      before do
        stub_request(:get, "https://web-proxy.io/proxy/api.ipify.org?format=json").
          with(
            headers: {
              'Accept'=>'*/*',
              'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'User-Agent'=>'Faraday v1.3.0'
            }).to_return(status: 200, body: {ip: '1.1.1.1'}.to_json, headers: {})
      end

      it 'returns the content of given URL through proxy' do
        expect(content).to have_key('ip')
        expect { IPAddr.new(content['ip']) }.to_not raise_error
      end
    end
  end
end

