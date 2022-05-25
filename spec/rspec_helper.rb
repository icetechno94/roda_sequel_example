# frozen_string_literal: true

ENV['RACK_ENV'] = 'test'

require 'rspec'
require 'json'
require 'factory_bot'
require 'faker'
require 'rack/test'
require_relative '../config/application'
require_relative '../app'
require 'database_cleaner-sequel'

require 'simplecov'
SimpleCov.start

Dir['./spec/factories/**/*.rb'].sort.each { |f| require f }
Dir['./spec/support/**/*.rb'].sort.each { |f| require f }

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  config.include Rack::Test::Methods
  config.include JsonHelper
  config.include RequestHelper, type: :request

  DatabaseCleaner[:sequel].strategy = :truncation
  DatabaseCleaner[:sequel].db = Config::DB.connect
  config.around(:example) do |ex|
    DatabaseCleaner[:sequel].start
    ex.run
    DatabaseCleaner[:sequel].clean
  end
end

def json_body(body = last_response.body)
  JSON.parse(body, symbolize_names: true)
end

def app
  App
end
