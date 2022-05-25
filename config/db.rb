# frozen_string_literal: true

require_relative '../.env'
require 'logger'
require 'sequel/core'

module Config
  # Main db config
  module DB
    def self.connect
      db = Sequel.connect(
        host: ENV.fetch('DATABASE_HOST', 'localhost'),
        user: ENV.fetch('DATABASE_USER_NAME'),
        adapter: 'postgres',
        database: ENV.fetch('DATABASE_NAME'),
        password: ENV.fetch('DATABASE_USER_PASSWORD', ''),
        port: ENV.fetch('DATABASE_PORT', 5432),
        pool: ENV.fetch('DATABASE_POOL', 10)
      )
      if db.loggers.empty?
        logger = Logger.new($stdout)
        db.loggers << logger
      end
      db
    end
  end
end
