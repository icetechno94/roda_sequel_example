# frozen_string_literal: true

require_relative '../.env'
require 'sequel/core'

# Delete APP_DATABASE_URL from the environment, so it isn't accidently
# passed to subprocesses.  APP_DATABASE_URL may contain passwords.
DB = Sequel.connect(ENV.delete('RODA_SEQUEL_EXAMPLE_DATABASE_URL') || ENV.delete('DATABASE_URL'))

# Load Sequel Database/Global extensions here
# DB.extension :date_arithmetic
