# frozen_string_literal: true

ENV['DATABASE_HOST']='localhost'
ENV['DATABASE_USER_NAME']='roda_sequel_example'
ENV['DATABASE_USER_PASSWORD'] = ''
case ENV['RACK_ENV'] ||= 'development'
when 'test'
  ENV['DATABASE_NAME'] ||='roda_sequel_example_test'
when 'development'
  ENV['DATABASE_NAME'] ||='roda_sequel_example_development'
end
