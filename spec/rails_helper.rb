# spec/rails_helper.rb
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
abort("The Rails environment is running in production mode!") if Rails.env.production?

require 'rspec/rails'
require 'capybara/rspec'

# support 読み込み
Rails.root.glob('spec/support/**/*.rb').sort.each { |f| require f }

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end

RSpec.configure do |config|
  config.fixture_paths = [Rails.root.join('spec/fixtures')]
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  # FactoryBot
  config.include FactoryBot::Syntax::Methods

  # controller spec 用（必要なら）
  config.include Devise::Test::ControllerHelpers, type: :controller

  # request spec 用（必要なら）
  config.include Devise::Test::IntegrationHelpers, type: :request

  # system spec 用（ログイン補助を使うなら）
  config.include Warden::Test::Helpers, type: :system
  config.after(:each, type: :system) { Warden.test_reset! }

  # あなたの sign_in_as を system でも使いたいなら
  config.include SignInHelper, type: :system

  config.before(:each, type: :system) do
    driven_by :rack_test
  end
end
