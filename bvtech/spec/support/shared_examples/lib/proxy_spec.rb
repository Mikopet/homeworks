RSpec.shared_examples "a proxy call" do
  let(:content) { subject.get_content(query_url) }

  context 'given URL is invalid' do
    let(:query_url) { 'not so good URL, \'"+!%/=()Ö' }

    it 'raises error' do
      expect { content }.to raise_error(URI::InvalidURIError)
    end
  end

  context 'given URL is valid' do
    let(:query_url) { 'api.ipify.org?format=json' }

    before do
      stub_request(:get, "#{proxy_url || 'https://'}#{query_url}").
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

