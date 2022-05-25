# frozen_string_literal: true

require_relative 'db'
require 'sequel/model'

if ENV['RACK_ENV'] == 'development'
  Sequel::Model.plugin :subclasses
  Sequel::Model.cache_associations = false
end

Sequel::Model.plugin :auto_validations
Sequel::Model.plugin :json_serializer

unless defined?(Unreloader)
  require 'rack/unreloader'
  Unreloader = Rack::Unreloader.new(reload: false)
end

Config::DB.connect
Unreloader.require('app/models') { |f| Sequel::Model.send(:camelize, File.basename(f).sub(/\.rb\z/, '')) }
