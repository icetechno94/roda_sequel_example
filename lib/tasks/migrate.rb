# frozen_string_literal: true

namespace :db do
  namespace :migrate do
    migrate = lambda do |env, version|
      ENV['RACK_ENV'] = env
      require_relative '../../config/db'
      Sequel.extension :migration
      Sequel::Migrator.apply(Config::DB.connect, 'db/migrate', version)
    end

    namespace :test do
      desc 'Migrate test database to latest version'
      task :up do
        migrate.call('test', nil)
      end

      desc 'Migrate test database all the way down'
      task :down do
        migrate.call('test', 0)
      end

      desc 'Migrate test database all the way down and then back up'
      task :bounce do
        migrate.call('test', 0)
        Sequel::Migrator.apply(Config::DB.connect, 'db/migrate')
      end
    end

    namespace :dev do
      desc 'Migrate development database to latest version'
      task :up do
        migrate.call('development', nil)
      end

      desc 'Migrate development database to all the way down'
      task :down do
        migrate.call('development', 0)
      end

      desc 'Migrate development database all the way down and then back up'
      task :bounce do
        migrate.call('development', 0)
        Sequel::Migrator.apply(Config::DB.connect, 'db/migrate')
      end
    end
  end
end
