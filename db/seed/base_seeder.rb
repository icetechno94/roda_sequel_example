# frozen_string_literal: true

require 'faker'
require_relative 'role_seeder'
require_relative 'user_seeder'
require_relative '../../config/models'

# Base Seeder
module BaseSeeder
  module_function

  def call(number)
    RoleSeeder.call(number)
    UserSeeder.call(number)
  end
end
