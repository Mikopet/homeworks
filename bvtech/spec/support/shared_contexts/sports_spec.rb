RSpec.shared_context 'using sports.json endpoint' do
  let(:response) do
    [
      {id: 1100, description: 'Handball'},
      {id: 240, description: 'Football'}
    ]
  end

  before do
    @endpoint = stub_request(:get, "#{proxy_url || 'http://'}#{query_url}").
      with(
        headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v1.3.0'
        }).to_return(
          status: 200, 
          body: response.to_json,
          headers: {}
        )
  end

  it 'calls the given URL according to proxy setting' do
    subject
    expect(@endpoint).to have_been_requested
  end
end

