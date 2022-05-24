# frozen_string_literal: true

case ENV['RACK_ENV'] ||= 'development'
when 'test'
  ENV['RODA_SEQUEL_EXAMPLE_DATABASE_URL'] ||= 'postgres:///roda_sequel_example_test?user=roda_sequel_example'
when 'development'
  ENV['RODA_SEQUEL_EXAMPLE_DATABASE_URL'] ||= 'postgres:///roda_sequel_example_development?user=roda_sequel_example'
end
