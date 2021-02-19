RSpec.configure do |config|
  DatabaseCleaner.url_allowlist = ['postgres://app:app@db:5432/app', 'postgres://postgres:postgres@localhost:5432/app_test']

  config.before(:suite) do
    DatabaseCleaner.clean_with :truncation, except: %w(ar_internal_metadata)
    DatabaseCleaner.strategy = :transaction
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end

