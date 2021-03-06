# frozen_string_literal: true

dev = ENV['RACK_ENV'] == 'development'

if dev
  require 'logger'
  logger = Logger.new($stdout)
end

require 'rack/unreloader'
Unreloader = Rack::Unreloader.new(subclasses: %w[Roda Sequel::Model], logger: logger, reload: dev) { App }

require_relative 'config/models'

Unreloader.require('app.rb') { 'App' }
run(dev ? Unreloader : Router.freeze.app)
