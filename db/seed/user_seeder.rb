# frozen_string_literal: true

require_relative '../../app/services/create_user_service'

module BaseSeeder
  # Seeder for user(and user_role)
  class UserSeeder
    def self.call(number)
      new(number)
    end

    def initialize(number)
      @number = number
      @roles = Role.order(Sequel.lit('RANDOM()')).limit(number)
      seed_users
    end

    private

    attr_reader :number, :roles

    def seed_users
      number.times do
        email = Faker::Internet.email
        create_user_with_relations(email)
        create_user_with_relations(email, blocked: true)
      end
    end

    def create_user_with_relations(email, blocked: false)
      user = create_user(email, blocked: blocked)
      seed_user_with_role(user)
    end

    def create_user(email, blocked: false)
      user = CreateUserService.call(email: email, blocked: blocked)
      p " => user created #{user.to_json}"
      user
    rescue CreateUserService::NotValidUser => _e
      create_user(email, blocked: blocked)
    end

    def seed_user_with_role(user)
      roles.each do |role|
        user.add_user_role(role: role)
        p "   => with #{role.name}"
      end
    end
  end
end
