RSpec.describe WebProxy do
  subject { described_class.new(proxy_url: proxy_url) }
  let(:proxy_url) { described_class::DEFAULT_WEB_PROXY }

  describe '#initialize' do
    context 'with no constructor params' do
      it 'raises error' do
        expect { described_class.new }.to_not raise_error
      end
    end

    context 'with default `proxy_url`' do
      it 'raises nothing' do
        expect { subject }.to_not raise_error
      end
    end
  end

  describe '#get_content with default `proxy_url`' do
    it_behaves_like 'a proxy call'
  end

  describe '#get_content with empty `proxy_url`' do

    it_behaves_like 'a proxy call' do
      let(:proxy_url) { nil }
    end
  end
end

