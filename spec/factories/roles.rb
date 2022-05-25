# frozen_string_literal: true

FactoryBot.define do
  factory :role, class: Role do
    name { Faker::Job.title }

    after(:build) do |role|
      role.key = role.name.underscore
    end
    to_create(&:save)
  end
end
