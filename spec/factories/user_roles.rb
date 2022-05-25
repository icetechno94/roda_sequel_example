# frozen_string_literal: true

FactoryBot.define do
  factory :user_role, class: UserRole do
    user
    role

    to_create(&:save)
  end
end
