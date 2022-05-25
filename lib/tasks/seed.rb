# frozen_string_literal: true

# Seeds
namespace :seed do
  desc 'Seed dev db'
  task :dev do
    require_relative '../../db/seed/base_seeder'
    BaseSeeder.call(10)
  end
end
