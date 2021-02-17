describe 'rake sync:sports', type: :task do
  let(:query_url) { 'localhost/sports.json' }

  context 'without arguments' do
    it 'preloads the Rails environment' do
      expect(task.prerequisites).to include 'environment'
    end

    it 'raises without arguments' do
      expect { task.execute }.to raise_error
    end
  end

  context 'with only url argument' do
    subject { task.invoke(query_url) }

    include_context 'using sports.json endpoint' do
      let(:proxy_url) { nil }
    end

    include_examples 'synchronizing to the DB'
  end

  context 'with url and false proxy args' do
    subject { task.invoke(query_url, false) }

    include_context 'using sports.json endpoint' do
      let(:proxy_url) { nil }
    end

    include_examples 'synchronizing to the DB'
  end

  context 'with url and true proxy args' do
    subject { task.invoke(query_url, true) }

    include_context 'using sports.json endpoint' do
      let(:proxy_url) { WebProxy::DEFAULT_WEB_PROXY }
    end

    include_examples 'synchronizing to the DB'
  end
end
