ENV["RAILS_ENV"] ||= 'test'
require File.expand_path('../config/environment', __dir__)
require 'rspec/rails'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include FactoryBot::Syntax::Methods

  config.before(:each) do
    DatabaseCleaner.clean
  end
end
