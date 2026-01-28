# spec/rails_helper.rb

require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'

abort("The Rails environment is running in production mode!") if Rails.env.production?

require 'rspec/rails'
require 'capybara/rspec'

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end

RSpec.configure do |config|
  config.fixture_paths = [
    Rails.root.join('spec/fixtures')
  ]

  # FactoryBot
  config.include FactoryBot::Syntax::Methods

  # Use transactional fixtures
  config.use_transactional_fixtures = true

  # === system spec 用（ここが超重要）===
  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  # JS を使う system spec を書く場合はこちら
  # config.before(:each, type: :system, js: true) do
  #   driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400]
  # end

  # spec/system => type: :system になる
  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!
end
