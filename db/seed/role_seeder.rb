# frozen_string_literal: true

require_relative '../../app/services/create_role_service'

module BaseSeeder
  # Role model seeder
  class RoleSeeder
    def self.call(number)
      new(number)
    end

    def initialize(number)
      @number = number
      seed_roles
    end

    private

    attr_reader :number

    def seed_roles
      number.times do
        create_role
      end
    end

    def create_role
      role = CreateRoleService.call(name: Faker::Job.title)
      p " => role created #{role.name}"
    rescue CreateRoleService::NotValidRole => _e
      create_role
    end
  end
end
