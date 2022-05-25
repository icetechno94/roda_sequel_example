# frozen_string_literal: true

require_relative '../../config/db'

Sequel.migration do
  Config::DB.connect.run 'CREATE EXTENSION IF NOT EXISTS "uuid-ossp";'
end
