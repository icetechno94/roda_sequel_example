# frozen_string_literal: true

namespace :db do
  namespace :create do
    desc 'Create test the database'
    task :test do
      create_db('test')
      puts '<= db:create executed'
    end

    desc 'Create dev the database'
    task :dev do
      create_db('development')
      puts '<= db:create executed'
    end
  end

  namespace :drop do
    desc 'Drop test the database'
    task :test do
      drop_db('test')
      puts '<= db:drop executed'
    end

    desc 'Drop dev the database'
    task :dev do
      drop_db('development')
      puts '<= db:drop executed'
    end
  end

  def create_db(env)
    ENV['RACK_ENV'] = env
    require_relative '../../config/db'
    environment = {}
    environment['PGUSER']     = ENV['DATABASE_USER_NAME']
    environment['PGPASSWORD'] = ''
    arguments = []
    arguments << "--host=#{ENV['DATABASE_HOST']}"
    arguments << "--username=#{ENV['DATABASE_USER_NAME']}"
    arguments << ENV['DATABASE_NAME']
    Process.wait Process.spawn(environment, 'createdb', *arguments)
  end

  def drop_db(env)
    ENV['RACK_ENV'] = env
    require_relative '../../config/db'
    environment = {}
    environment['PGUSER']     = ENV['DATABASE_USER_NAME']
    environment['PGPASSWORD'] = ''
    arguments = []
    arguments << '--host=localhost'
    arguments << '--username=roda_sequel_example'
    arguments << ENV['DATABASE_NAME']
    Process.wait Process.spawn(environment, 'dropdb', *arguments)
  end
end
